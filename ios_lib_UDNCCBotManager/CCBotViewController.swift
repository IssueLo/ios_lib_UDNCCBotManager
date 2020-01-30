//
//  CCBotViewController.swift
//  ccbotPractice3
//
//  Created by 羅翊修 on 2020/1/17.
//  Copyright © 2020 羅翊修. All rights reserved.
//

import UIKit
import WebKit

class CCBotViewController: UIViewController {
    
    // MARK: Properties
    /// - Parameters:
    ///   - webView: `WKWebView`
    ///   - webViewConfig: For receiving messages from JavaScript
    ///   - url: URL of webView, set at `viewDidLoad`
    ///   - dismissHandle: When `CCBotViewController` dismiss, background coverView alpha == 0
    private var webView: WKWebView!
    private let webViewConfig = WKWebViewConfiguration()
    var url: String!
    var dismissHandler: (() -> ())?
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        setWebViewConfig()
        if let url = url {
            setWebView(urlString: url)
        }
    }
    
    // MARK: Method
    /// Set WebViewConfig with `CCBotWKScriptName` for receiving messages from JavaScript
    private func setWebViewConfig() {
        
        webViewConfig.userContentController = WKUserContentController()
        webViewConfig.userContentController.add(self, name: CCBotModel.WKScriptName.close)
    }
    
    /// Set WebView with  `WKWebViewConfiguration`, `CornerRadius`, `AutoLayout`and `URL`
    private func setWebView(urlString: String) {
        
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.addCornerRadius(corners: [Corner.topLeft.mask, Corner.topRight.mask], radius: 8)
        webView.scrollView.bounces = false

        view.addSubview(webView)

        let layoutGuide = view.safeAreaLayoutGuide
        webView.anchor(top: view.topAnchor,
                       leading: layoutGuide.leadingAnchor,
                       bottom: view.bottomAnchor,
                       trailing: layoutGuide.trailingAnchor,
                       padding: UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0))

        if let url = URL(string: url) {
            self.webView.load(URLRequest(url: url))
        }
    }
}

extension CCBotViewController: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        let messageString = message.body as! String
        
        if messageString == "" {
            
            dismissHandler?()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
