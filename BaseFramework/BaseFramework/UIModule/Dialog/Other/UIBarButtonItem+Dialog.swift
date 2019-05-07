//
//  UIBarButtonItem+Dialog.swift
//  Dialog
//
//  Created by Max on 2018/8/17.
//  Copyright © 2018年 Kucoin. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    static func emptyItem(_ size: CGSize) -> UIBarButtonItem {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        return UIBarButtonItem(customView: view)
    }

    static func flexibleItem() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                               target: nil,
                               action: nil)
    }
}

extension UIToolbar {
    func clearBackground() {
        setBackgroundImage(UIImage(), forToolbarPosition: .any, barMetrics: .default)
        clipsToBounds = true
    }
}
