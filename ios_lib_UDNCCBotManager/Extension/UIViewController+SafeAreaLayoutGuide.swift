//
//  UIViewController+SafeAreaLayoutGuide.swift
//  ios_lib_UDNCCBotManager
//
//  Created by 羅翊修 on 2020/2/3.
//  Copyright © 2020 羅翊修. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// safeAreaLayoutGuide is not support on iOS 9.0 / 10.0
    /// Reference URL: https://gist.github.com/marianoabdala/2e873480646d3f85d1aae21813554658
    var ft_safeAreaLayoutGuide: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return view.safeAreaLayoutGuide
        } else {
            let id = "ft_safeAreaLayoutGuide"
            
            if let layoutGuide = view.layoutGuides.filter({ $0.identifier == id }).first {
                return layoutGuide
            } else {
                let layoutGuide = UILayoutGuide()
                layoutGuide.identifier = id
                view.addLayoutGuide(layoutGuide)
                layoutGuide.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
                layoutGuide.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                layoutGuide.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                layoutGuide.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor).isActive = true
                return layoutGuide
            }
        }
    }
    
}

