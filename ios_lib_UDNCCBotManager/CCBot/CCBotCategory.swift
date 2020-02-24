//
//  CCBotCategory.swift
//  ccbotPractice3
//
//  Created by 羅翊修 on 2020/1/17.
//  Copyright © 2020 羅翊修. All rights reserved.
//

import UIKit

public enum CCBotCategory {
        
    case udnNews
    case utravel
    
    var urlPath: String {
        
        switch self {
        case .udnNews: return "udn"
        case .utravel: return "utravel"
        }
    }
    
    /* - icon 由 app 設定
    var iconImage: UIImage? {
        
        UIImage(named: self.model.image, in: CCBotModel.imageBundle, compatibleWith: nil)
    }
     */
}
