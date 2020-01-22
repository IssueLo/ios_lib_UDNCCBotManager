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
            setCCBotButton()
        }
    }
    public var ccBotCategory: CCBotCategory! {
        didSet {
            setCCBotViewController()
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
    static var imageBundle: Bundle {
        let path = Bundle(for: CCBotManager.self).resourcePath! + "/CCBotManager.bundle"
        return Bundle(path: path)!
    }
    
    // MARK: Method
    /// Set CCBotViewController
    private func setCCBotViewController() {
        
        ccBotViewController.url = ccBotCategory.url
        ccBotViewController.dismissHandler = {
            UIView.animate(withDuration: 0.5) {
                self.coverView.alpha = 0
            }
        }
    }
    
    /// Set ChatBot Button `AutoLayout`, `UIImage` and `Target`
    private func setCCBotButton() {
        
        let superView = superViewController.view!
        superView.addSubview(ccBotButton)
        
        ccBotButton.anchor(top: nil,
                           leading: nil,
                           bottom: superView.safeAreaLayoutGuide.bottomAnchor,
                           trailing: superView.trailingAnchor,
                           padding: UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0))
        
        ccBotButton.setImage(CCBotCategory.utravel.iconImage, for: .normal)
        
        ccBotButton.addTarget(self, action: #selector(presentCCBotVC), for: .touchUpInside)
    }
    
    /// `ChatBot Button Target` - Present CCBotViewController
    @objc
    private func presentCCBotVC() {

        superViewController.view.addSubview(coverView)
        coverView.backgroundColor = .black
        coverView.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.coverView.alpha = 0.4
        }
        
        ccBotViewController.modalPresentationStyle = .overCurrentContext
        superViewController.present(ccBotViewController, animated: true, completion: nil)
    }
}
