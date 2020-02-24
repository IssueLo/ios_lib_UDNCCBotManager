//
//  CCBotModel.swift
//  ios_lib_UDNCCBotManager
//
//  Created by 羅翊修 on 2020/1/30.
//  Copyright © 2020 羅翊修. All rights reserved.
//

public enum CCBotEnvironment {
    
    case test
    case release
    
    var urlPath: String {
        
        switch self {
        case .test: return "https:ccbot-testfront.udn-device-dept.net/#/"
        case .release: return "https:ccbot/#/"
        }
    }
}

struct CCBotModel {
    
    static func getURL(with category: CCBotCategory,
                       for environment: CCBotEnvironment) -> String {
        let categoryURLPath = category.urlPath
        let environmentURLPath = environment.urlPath
        let platform = "?app=true"
        let url = environmentURLPath + categoryURLPath + platform
        return url
    }
    
    struct WKScriptName {
        static let close = "botclosed"
    }
    
    /* - icon 由 app 設定
    static var imageBundle: Bundle {
        let path = Bundle(for: CCBotManager.self).resourcePath! + "/CCBotManager.bundle"
        return Bundle(path: path)!
    }
     */
}
