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
    ///   - button: ChatBot Button on the Screen
    ///   - ccBotCategory: Project Category
    ///   - isOpen: ChatBot Button control with `UISwitch`, default is `true`
    ///   - delegate: Delegate of `CCBotViewController`, default is `nil`
    public func setting(superViewController: UIViewController,
                        button: UIButton,
                        ccBotCategory: CCBotCategory,
                        isOpen: Bool = true,
                        delegate: AnyObject? = nil) {
        
        self.superViewController = superViewController
        self.ccBotButton = button
        self.ccBotCategory = ccBotCategory
        self.isOpen = isOpen
        self.delegate = delegate
        ccBotButton.addTarget(self, action: #selector(presentCCBotVC), for: .touchUpInside)
    }
    
    // MARK: Main Properties
    public var superViewController: UIViewController!
    public var ccBotButton: UIButton! {
        didSet {
            ccBotButton.addTarget(self, action: #selector(presentCCBotVC), for: .touchUpInside)
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
    public weak var delegate: AnyObject? {
        didSet {
            if ccBotCategory == .udnNews {
                newsDelegate = delegate as? CCBotNewsDelegate
            } else if ccBotCategory == .utravel {
                travelDelegate = delegate as? CCBotTravelDelegate
            }
        }
    }

    // MARK: Other Properties
    /// - Parameters:
    ///   - ccBotViewController: ViewController for WebView, default is `CCBotViewController()`
    ///   - coverView: Create animation when present ChatBotView
    private let ccBotViewController: CCBotViewController = CCBotViewController()
    private let coverView: UIView = UIView()
    private weak var newsDelegate: CCBotNewsDelegate? {
        didSet {
            ccBotViewController.newsDelegate = newsDelegate
        }
    }
    private weak var travelDelegate: CCBotTravelDelegate? {
        didSet {
            ccBotViewController.travelDelegate = travelDelegate
        }
    }
    
    // MARK: Method
    /// Set CCBotViewController `WebViewURL` and CCBotButton `UIImage`
    private func ccBotSetting(with category: CCBotCategory) {
        
        ccBotButton.setImage(category.iconImage, for: .normal)
        ccBotViewController.url = category.url
    }
    
    /// Set CCBotButton `AutoLayout`
    private func ccBotBtnLayout(on superViewController: UIViewController) {
                
        superViewController.view.addSubview(ccBotButton)
        ccBotButton.anchor(top: nil,
                           leading: nil,
                           bottom: superViewController.ft_safeAreaLayoutGuide.bottomAnchor,
                           trailing: superViewController.view.trailingAnchor,
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
