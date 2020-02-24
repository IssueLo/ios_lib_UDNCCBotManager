//
//  CCBotManager.swift
//  ccbotPractice3
//
//  Created by 羅翊修 on 2020/1/17.
//  Copyright © 2020 羅翊修. All rights reserved.
//

import UIKit

public class CCBotManager {
    
    // MARK: - Singleton Plus
    public static let shared = CCBotManager()
    
    /// setting `CCBotManager`
    /// - Parameters:
    ///   - superViewController: SuperView for ChatBot Button
    ///   - button: ChatBot Button on the Screen
    ///   - ccBotCategory: Project Category
    ///   - environment: Select `test` or `release`
    ///   - isActive: Control ChatBot Button with `UISwitch`, default is `true`
    ///   - delegate: Delegate of `CCBotViewController`, default is `nil`
    public func setting(superViewController: UIViewController,
                        button: UIButton,
                        ccBotCategory: CCBotCategory,
                        environment: CCBotEnvironment,
                        isActive: Bool = true,
                        delegate: AnyObject? = nil) {
        
        self.superViewController = superViewController
        self.ccBotButton = button
        self.ccBotCategory = ccBotCategory
        self.environment = environment
        ccBotViewController.url = CCBotModel.getURL(with: ccBotCategory,
                                                    for: environment)

        // Optional
        self.isActive = isActive
        self.delegate = delegate
    }
    
    // MARK: - Main Properties
    public var superViewController: UIViewController!
    public var ccBotButton: UIButton! {
        didSet {
            ccBotButton.addTarget(self, action: #selector(presentCCBotVC), for: .touchUpInside)
        }
    }
    public var ccBotCategory: CCBotCategory!
    public var environment: CCBotEnvironment!
    
    public var isActive: Bool! {
        didSet {
            if isActive {
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

    // MARK: - Other Properties
    /// - Parameters:
    ///   - ccBotViewController: ViewController for WebView
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
    
    // MARK: - Method
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
