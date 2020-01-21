//
//  UIView+CornerRadius.swift
//  ccbotPractice3
//
//  Created by 羅翊修 on 2020/1/17.
//  Copyright © 2020 羅翊修. All rights reserved.
//

import UIKit

extension UIView {
    
    /// CornerRadius Method
    func addCornerRadius(corners: CACornerMask, radius: CGFloat) {
        
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
}

enum Corner {
    
    case topLeft
    case topRight
    case bottomLeft
    case bottomRight
    
    /// Get the mask of corners
    var mask: CACornerMask {
        
        switch self {
        case .topLeft: return .layerMinXMinYCorner
        case .topRight: return .layerMaxXMinYCorner
        case .bottomLeft: return .layerMinXMaxYCorner
        case .bottomRight: return .layerMaxXMaxYCorner
        }
    }
}
