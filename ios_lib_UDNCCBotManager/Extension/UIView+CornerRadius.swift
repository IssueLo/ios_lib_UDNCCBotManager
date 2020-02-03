//
//  UIView+CornerRadius.swift
//  ccbotPractice3
//
//  Created by 羅翊修 on 2020/1/17.
//  Copyright © 2020 羅翊修. All rights reserved.
//

import UIKit

extension UIView {
    
    /// CornerRadius Method for iOS 11+
    @available(iOS 11.0, *)
    func addCornerRadius(corners: CACornerMask, radius: CGFloat) {
        
        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
    
    /// CornerRadius Method for iOS 9 / 10
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
     
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = path.cgPath
        self.layer.mask = maskLayer
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
