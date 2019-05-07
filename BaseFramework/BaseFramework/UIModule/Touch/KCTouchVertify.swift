/*******************************************************************************
 # File        : KCTouchVertify.swift
 # Project     : &&&&
 # Author      : shenghai
 # Created     : 2018/9/25
 # Corporation : ****
 # Description : 指纹验证弹框
 -------------------------------------------------------------------------------
 # Date        :
 # Author      :
 # Notes       :
 ******************************************************************************/

import UIKit
import LocalAuthentication

class KCTouchVertify {
    static func opeTouchID(_ block: ((Bool) -> Void)?) {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // 开始进入识别状态，以闭包形式返回结果。闭包的 success 是布尔值，代表识别成功与否。error 为错误信息。
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "请验证指纹",
                                   reply: { (success, _) in
                DispatchQueue.main.async {
                    block?(success)
                }
            })
        } else {
            block?(false)
        }
    }
}
