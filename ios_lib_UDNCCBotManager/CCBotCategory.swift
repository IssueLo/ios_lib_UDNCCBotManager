//
//  CCBotCategory.swift
//  ccbotPractice3
//
//  Created by 羅翊修 on 2020/1/17.
//  Copyright © 2020 羅翊修. All rights reserved.
//

import UIKit

public enum CCBotCategory: String {
        
    case utravel = "utravel"
    
    var iconImage: UIImage? {
        switch self {
        case .utravel: return UIImage(named: "chatbot_head", in: CCBotManager.imageBundle, compatibleWith: nil)
        }
    }
    
    var url: String {
        switch self {
        case .utravel: return CCBotURLModel.getURL(with: self)
        }
    }
    
    private struct CCBotURLModel {
        
        static let path = "https:ccbot-testfront.udn-device-dept.net/#/"
        static let platform = "?app=true"
        
        static func getURL(with ccBotCategory: CCBotCategory) -> String {
            let url = path + ccBotCategory.rawValue + platform
            return url
        }
    }
}

public struct CCBotWKScriptName {
    
    public static let close = "botclosed"
}
