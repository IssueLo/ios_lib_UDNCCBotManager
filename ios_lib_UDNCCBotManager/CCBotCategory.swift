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
    
    private var model: CCBotCategoryModel {
        switch self {
        case .udnNews: return CCBotCategoryModel(category: "udn", image: "chatbot_head")
        case .utravel: return CCBotCategoryModel(category: "utravel", image: "chatbot_head")
        }
    }
    
    var url: String {
        CCBotModel.getURL(with: self.model.category)
    }
    
    var iconImage: UIImage? {
        UIImage(named: self.model.image, in: CCBotModel.imageBundle, compatibleWith: nil)
    }
}

struct CCBotCategoryModel {
    
    let category: String
    let image: String
    
    init(category: String, image: String) {
        self.category = category
        self.image = image
    }
}
