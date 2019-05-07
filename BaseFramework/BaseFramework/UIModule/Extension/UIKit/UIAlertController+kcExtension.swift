/*******************************************************************************
 # File        : UIAlertController+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

var cancelActionClosureKey  = 101
var confirmActionClosureKey = 102

var cancelTitleKey          = 103
var confirmTitleKey         = 104

extension UIAlertController {

//  var titleColor: UIColor = UIColor?
//  var msgColor: UIColor = UIColor?
//  var cancleTitleColor: UIColor?
//  var confirmTitleColor: UIColor?
//  action.setValue(cancleTitleColor, forKey: "titleTextColor")

    var cancelActionClosure: ((UIAlertAction) -> Void)? {
        set {
            objc_setAssociatedObject(self, &cancelActionClosureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }

        get {
            if let rs = objc_getAssociatedObject(self, &cancelActionClosureKey) as? (UIAlertAction) -> Void {
                return rs
            }
            return nil
        }
    }

    var confirmActionClosure: ((UIAlertAction) -> Void)? {
        set {
            objc_setAssociatedObject(self, &confirmActionClosureKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }

        get {
            if let rs = objc_getAssociatedObject(self, &confirmActionClosureKey) as? (UIAlertAction) -> Void {
                return rs
            }
            return nil
        }
    }

    var cancelTitle: String {
        set {
            objc_setAssociatedObject(self, &cancelTitleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }

        get {
            if let rs = objc_getAssociatedObject(self, &cancelTitleKey) as? String {
                return rs
            }
            return ""
        }
    }

    var confirmTitle: String {
        set {
            objc_setAssociatedObject(self, &confirmTitleKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }

        get {
            if let rs = objc_getAssociatedObject(self, &confirmTitleKey) as? String {
                return rs
            }
            return ""
        }
    }

    func show() {
        if !self.cancelTitle.isEmpty {
             self.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: cancelActionClosure))
        }
        if !self.confirmTitle.isEmpty {
            self.addAction(UIAlertAction(title: confirmTitle, style: .default, handler: confirmActionClosure))
        }
        UIWindow.topViewController()?.present(self, animated: true, completion: nil)
    }

    func cancelActionClosure(_ closure: @escaping (UIAlertAction) -> Void) -> Self {
        cancelActionClosure = closure
        return self
    }

    func confirmActionClosure(_ closure: @escaping (UIAlertAction) -> Void) -> Self {
        confirmActionClosure = closure
        return self
    }

    static func makeAlert(_ closure: ((UIAlertController) -> Void)) -> UIAlertController {
        let maker = UIAlertController(title: "", message: "", preferredStyle: .alert)
        closure(maker)
        return maker
    }

    /// 展示AlterController
    ///
    /// - Parameters:
    ///   - title: 标题
    ///   - message: 信息
    ///   - cancelTitle: 取消按钮内容
    ///   - otherTitle: 其他按钮内容
    ///   - cancelAction: 取消按钮回调
    ///   - otherAction: 其他按钮回调
    // swiftlint:disable function_parameter_count
    static func showAlertController(_ title: String,
                                    message: String,
                                    cancelTitle: String,
                                    otherTitle: String?,
                                    cancelAction:@escaping ((UIAlertAction) -> Void),
                                    otherAction: ((UIAlertAction) -> Void)?) {

        if let other = otherTitle, let action = otherAction {
            UIAlertController.makeAlert { (make) in
                    make.title = title
                    make.message = message
                    make.cancelTitle = cancelTitle
                    make.confirmTitle = other
                }
                .cancelActionClosure(cancelAction)
                .confirmActionClosure(action)
                .show()
        } else {
            UIAlertController.makeAlert { (make) in
                    make.title = title
                    make.message = message
                    make.cancelTitle = cancelTitle
                }
                .cancelActionClosure(cancelAction)
                .show()
        }
    }
}
