//
//  CCBotViewController.swift
//  ccbotPractice3
//
//  Created by 羅翊修 on 2020/1/17.
//  Copyright © 2020 羅翊修. All rights reserved.
//

import UIKit
import WebKit

public class CCBotViewController: UIViewController {
    
    // MARK: Properties
    /// - Parameters:
    ///   - webView:
    ///   - webViewConfig:
    ///   - url:
    ///   - dismissHandle:
    private var webView: WKWebView!
    private let webViewConfig = WKWebViewConfiguration()
    public var url: String = ""
    var dismissHandler: (() -> ())?
    
    // MARK: Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        setWebViewConfig()
        setWebView(urlString: url)
    }
    
    // MARK: Method
    /// Set WebViewConfig with `CCBotWKScriptName` for receiving messages from JavaScript
    private func setWebViewConfig() {
        
        webViewConfig.userContentController = WKUserContentController()
        webViewConfig.userContentController.add(self, name: CCBotWKScriptName.close)
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
                       padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0))

        if let url = URL(string: url) {
            self.webView.load(URLRequest(url: url))
        }
    }
}

extension CCBotViewController: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
         
        dismissHandler?()
        self.dismiss(animated: true, completion: nil)
    }
}
