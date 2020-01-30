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
    
    // MARK: Public Properties
    /// - Parameters:
    ///   - superViewController: SuperView for ChatBot Button
    ///   - ccBotCategory: Project Category
    ///   - isOpen: ChatBot Button control by `UISwitch`
    public var superViewController: UIViewController! {
        didSet {
            setCCBotManager(on: superViewController.view)
        }
    }
    public var ccBotCategory: CCBotCategory! {
        didSet {
            setCCBotManager(with: ccBotCategory)
        }
    }
    public var isOpen: Bool = true {
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
    ///   - imageBundle: Path of `Bundle`
    private let ccBotButton: UIButton = UIButton()
    private let ccBotViewController: CCBotViewController = CCBotViewController()
    lazy var coverView: UIView = UIView(frame: superViewController.view.frame)
    
    // MARK: Method
    /// Set CCBotViewController `WebViewURL` and CCBotButton `UIImage`
    private func setCCBotManager(with category: CCBotCategory) {
        
        ccBotButton.setImage(category.iconImage, for: .normal)
        ccBotViewController.url = category.url
        
    }
    
    /// Set CCBotButton `AutoLayout` and `Target`
    private func setCCBotManager(on superView: UIView) {
        
        superView.addSubview(ccBotButton)
        ccBotButton.anchor(top: nil,
                           leading: nil,
                           bottom: superView.safeAreaLayoutGuide.bottomAnchor,
                           trailing: superView.trailingAnchor,
                           padding: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
        
        ccBotButton.addTarget(self, action: #selector(presentCCBotVC), for: .touchUpInside)
    }
    
    /// `ChatBot Button Target` - Present CCBotViewController, Animation of CoverView
    @objc
    private func presentCCBotVC() {

        superViewController.view.addSubview(coverView)
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
