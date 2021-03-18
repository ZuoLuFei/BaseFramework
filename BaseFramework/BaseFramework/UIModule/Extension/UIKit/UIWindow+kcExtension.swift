/*******************************************************************************
 # File        : UIWindow+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit
import RTRootNavigationController

extension UIWindow {

    /// keyWindow的根控制器
    class public func getRootVC() -> UIViewController? {

        return UIApplication.shared.keyWindow?.rootViewController
    }

    /// 获取当前显示界面控制器
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        if let rtContainerController = controller as? RTContainerController {
            return topViewController(controller: rtContainerController.contentViewController)
        }
        return controller
    }

}
