/*******************************************************************************
 # File        : HUD.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/7/19
 # Corporation : ****
 # Description :
 <#Description Logs#>
 ******************************************************************************/

import UIKit

private let delayTime = 0.5

class HUD: NSObject {

    /// 提示信息(带成功提示图片)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    class public func showSuccess(_ message: String) {

        HUD._executeHUDTask {
            HUD.showSuccess(message, viewController: UIWindow.topViewController())
        }
    }

    /// 提示信息(带成功提示图片)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    ///   - viewController: 指定控制器
    class public func showSuccess(_ message: String, viewController: UIViewController?) {

        HUD._executeHUDTask {
            if let viewController = viewController {
                KRProgressHUD.set(maskType: .clear).set(style: .black).showOn(viewController).showImage(UIImage(named: "toast_succeed")!, size: CGSize.zero, message: message)

            } else {
                KRProgressHUD.set(maskType: .clear).set(style: .black).showImage(UIImage(named: "toast_succeed")!, size: CGSize.zero, message: message)
            }
        }
    }

    /// 提示信息(带失败提示图片)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    class public func showError(_ message: String) {

        HUD._executeHUDTask {
            HUD.showError(message, viewController: UIWindow.topViewController())
        }
    }

    /// 提示信息(带失败提示图片)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    ///   - viewController: 指定控制器
    class public func showError(_ message: String, viewController: UIViewController?) {

        HUD._executeHUDTask {
            if let viewController = viewController {
                KRProgressHUD.set(maskType: .clear).set(style: .black).showOn(viewController).showImage(UIImage(named: "toast_wrong")!, size: CGSize.zero, message: message)

            } else {
                KRProgressHUD.set(maskType: .clear).set(style: .black).showImage(UIImage(named: "toast_wrong")!, size: CGSize.zero, message: message)

            }
        }
    }

    /// 提示信息(带警告提示图片)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    class public func showWarning(_ message: String) {


        HUD._executeHUDTask {
            HUD.showWarning(message, viewController: UIWindow.topViewController())
        }
    }

    /// 提示信息(带警告提示图片)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    ///   - viewController: 指定控制器
    class public func showWarning(_ message: String, viewController: UIViewController?) {

        HUD._executeHUDTask {
            if let viewController = viewController {
                KRProgressHUD.set(maskType: .clear).set(style: .black).showOn(viewController).showImage(UIImage(named: "toast_warning")!, size: CGSize.zero, message: message)

            } else {
                KRProgressHUD.set(maskType: .clear).set(style: .black).showImage(UIImage(named: "toast_warning")!, size: CGSize.zero, message: message)
            }
        }
    }

    /// 提示信息(带Loading效果)
    class public func showLoading() {
        HUD._executeHUDTask {
            HUD.showLoading("加载中")
        }
    }

    /// 提示信息(带Loading效果)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    class public func showLoading(_ message: String) {

        HUD._executeHUDTask {
            HUD.showLoading(message, viewController: UIWindow.topViewController())
        }
    }

    /// 提示信息(带Loading效果)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    ///   - viewController: 指定控制器
    class public func showLoading(_ message: String, viewController: UIViewController?) {

        HUD._executeHUDTask {
            if let viewController = viewController {
                KRProgressHUD.set(maskType: .clear).set(style: .black).showOn(viewController).show(withMessage: message, completion: nil)

            } else {
                KRProgressHUD.set(maskType: .clear).set(style: .black).show(withMessage: message, completion: nil)

            }
        }
    }

    /// 提示信息(不带任何提示图片及效果)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    class public func showMessage(_ message: String) {

        HUD._executeHUDTask {
            HUD.showMessage(message, viewController: UIWindow.topViewController())
        }
    }

    /// 提示信息(不带任何提示图片及效果)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    ///   - viewController: 指定控制器
    class public func showMessage(_ message: String, viewController: UIViewController?) {


        HUD._executeHUDTask {
            if let viewController = viewController {
                KRProgressHUD.set(maskType: .clear).set(style: .black).showOn(viewController).showMessage(message)

            } else {
                KRProgressHUD.set(maskType: .clear).set(style: .black).showMessage(message)
            }
        }



    }

    /// 提示信息(不带任何提示图片及效果)
    ///
    /// - Parameters:
    ///   - message: 提示文字
    class public func dismissHUD() {

        KRProgressHUD.dismiss()
    }
}



// MARK: - 私有方法
extension HUD {

    /// 执行HUD任务
    static private func _executeHUDTask(_ execute: @escaping () -> Void) {
        if KRProgressHUD.isVisible {
            Thread.delay(delayTime) {
                execute()
            }
        } else {
            execute()
        }
    }
}
