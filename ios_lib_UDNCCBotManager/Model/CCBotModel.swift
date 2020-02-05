//
//  CCBotModel.swift
//  ios_lib_UDNCCBotManager
//
//  Created by 羅翊修 on 2020/1/30.
//  Copyright © 2020 羅翊修. All rights reserved.
//

struct CCBotModel {
    
    static func getURL(with category: String) -> String {
        let urlPath = "https:ccbot-testfront.udn-device-dept.net/#/"
        let platform = "?app=true"
        let url = urlPath + category + platform
        return url
    }
    
    static var imageBundle: Bundle {
        let path = Bundle(for: CCBotManager.self).resourcePath! + "/CCBotManager.bundle"
        return Bundle(path: path)!
    }
    
    struct WKScriptName {
        static let close = "botclosed"
    }
}
