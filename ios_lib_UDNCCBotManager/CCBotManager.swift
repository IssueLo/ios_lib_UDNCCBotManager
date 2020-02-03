//
//  CCBotManager.swift
//  ccbotPractice3
//
//  Created by 羅翊修 on 2020/1/17.
//  Copyright © 2020 羅翊修. All rights reserved.
//

import UIKit

public class CCBotManager {
    
    /// `Singleton Plus`
    public static let shared = CCBotManager()
    
    /// setting `CCBotManager`
    /// - Parameters:
    ///   - superViewController: SuperView for ChatBot Button
    ///   - ccBotCategory: Project Category
    ///   - isOpen: ChatBot Button control with `UISwitch`, default is `true`
    public func setting(superViewController: UIViewController,
                        ccBotCategory: CCBotCategory,
                        isOpen: Bool = true) {
        
        self.superViewController = superViewController
        self.ccBotCategory = ccBotCategory
        self.isOpen = isOpen
        ccBotButton.addTarget(self, action: #selector(presentCCBotVC), for: .touchUpInside)
    }
    
    // MARK: Main Properties
    public var superViewController: UIViewController! {
        didSet {
            ccBotBtnLayout(on: superViewController.view)
        }
    }
    public var ccBotCategory: CCBotCategory! {
        didSet {
            ccBotSetting(with: ccBotCategory)
        }
    }
    public var isOpen: Bool! {
        didSet {
            if isOpen {
                ccBotButton.isHidden = false
            } else {
                ccBotButton.isHidden = true
            }
        }
    }
    
    // MARK: Other Properties
    /// - Parameters:
    ///   - ccBotButton: ChatBot Button on the Screen, default is `UIButton()`
    ///   - ccBotViewController: ViewController for WebView, default is `CCBotViewController()`
    ///   - coverView: Create animation when present ChatBotView
    private let ccBotButton: UIButton = UIButton()
    private let ccBotViewController: CCBotViewController = CCBotViewController()
    private let coverView: UIView = UIView()
    
    // MARK: Method
    /// Set CCBotViewController `WebViewURL` and CCBotButton `UIImage`
    private func ccBotSetting(with category: CCBotCategory) {
        
        ccBotButton.setImage(category.iconImage, for: .normal)
        ccBotViewController.url = category.url
    }
    
    /// Set CCBotButton `AutoLayout`
    private func ccBotBtnLayout(on superView: UIView) {
                
        superView.addSubview(ccBotButton)
        
        var superViewBottomAnchor: NSLayoutYAxisAnchor?
        
        if #available(iOS 11.0, *) {
            superViewBottomAnchor = superView.safeAreaLayoutGuide.bottomAnchor
        } else {
            superViewBottomAnchor = superView.bottomAnchor
        }
        
        ccBotButton.anchor(top: nil,
                           leading: nil,
                           bottom: superViewBottomAnchor,
                           trailing: superView.trailingAnchor,
                           padding: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
    }
    
    /// `ChatBot Button Target` - Present CCBotViewController, Animation of CoverView
    @objc
    private func presentCCBotVC() {

        superViewController.view.addSubview(coverView)
        coverView.frame = superViewController.view.frame
        coverView.backgroundColor = .black
        coverView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.coverView.alpha = 0.4
        }
        ccBotViewController.dismissHandler = {
            UIView.animate(withDuration: 0.5) {
                self.coverView.alpha = 0
            }
        }
        
        ccBotViewController.modalPresentationStyle = .overCurrentContext
        superViewController.present(ccBotViewController, animated: true, completion: nil)
    }
}
