/*******************************************************************************
 # File        : UIView+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

extension UIView {

    /// 获取view所在的控制器
    func parentController() -> UIViewController? {
        var responder = self.next
        while responder != nil {
            if let vc = responder as? UIViewController {
                return vc
            }

            responder = responder?.next
        }

        return nil
    }
}
