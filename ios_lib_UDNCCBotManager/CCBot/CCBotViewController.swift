//
//  CCBotViewController.swift
//  ccbotPractice3
//
//  Created by 羅翊修 on 2020/1/17.
//  Copyright © 2020 羅翊修. All rights reserved.
//

import UIKit
import WebKit

public protocol CCBotNewsDelegate: AnyObject {
    
    func showNextNews(categaryID: Int, articleId: Int)
}

public protocol CCBotTravelDelegate: AnyObject {
    
}

class CCBotViewController: UIViewController {
    
    // MARK: - Properties
    /// - Parameters:
    ///   - webView: `WKWebView`
    ///   - webViewConfig: For receiving messages from JavaScript
    ///   - url: URL of webView, set at `viewDidLoad`
    ///   - dismissHandle: When `CCBotViewController` dismiss, background coverView alpha == 0
    ///   - newsDelegate: `CCBotUDNNewsDelegate`
    ///   - travelDelegate: `CCBotTravelDelegate`
    private var webView: WKWebView!
    private let webViewConfig = WKWebViewConfiguration()
    var url: String!
    var dismissHandler: (() -> ())?
    weak var newsDelegate: CCBotNewsDelegate?
    weak var travelDelegate: CCBotTravelDelegate?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        setWebViewConfig()
        if let url = url {
            setWebView(urlString: url)
        }
    }
    
    override func viewDidLayoutSubviews() {

        webView.roundCorners(corners: [.topLeft, .topRight], radius: 8)
    }
    
    // MARK: - Method
    /// Set WebViewConfig with `CCBotWKScriptName` for receiving messages from JavaScript
    private func setWebViewConfig() {

        webViewConfig.userContentController = WKUserContentController()
        
        // Define WKScriptName
        webViewConfig.userContentController.add(self, name: CCBotModel.WKScriptName.close)
    }
    
    /// Set WebView with  `WKWebViewConfiguration`, `CornerRadius`, `AutoLayout`and `URL`
    private func setWebView(urlString: String) {
        
        webView = WKWebView(frame: .zero, configuration: webViewConfig)
        webView.scrollView.bounces = false
        
        view.addSubview(webView)
        webView.anchor(top: ft_safeAreaLayoutGuide.topAnchor,
                       leading: view.leadingAnchor,
                       bottom: view.bottomAnchor,
                       trailing: view.trailingAnchor,
                       padding: UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0))

        if let url = URL(string: urlString) {
            self.webView.load(URLRequest(url: url))
        }
    }
}

extension CCBotViewController: WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
        let messageString = message.body as! String
        
        if messageString == "" {
            closed()
        } else {
            closed()
            if let data = messageString.data(using: .utf8) {
                showNextNew(with: data)
            }
        }
    }
    
    private func closed() {
        dismissHandler?()
        self.dismiss(animated: true, completion: nil)
    }
    
    // undNews
    private func showNextNew(with data: Data) {
        if let newsModel = DecoderManager.toNewsModel(data: data) {
            newsDelegate?.showNextNews(categaryID: newsModel.categoryId,
                                       articleId: newsModel.articleId)
        } else {
            // - TODO
            print("newsModel is nil")
        }
    }
}
