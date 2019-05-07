/*******************************************************************************
 # File        : KCToaster.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/9/25
 # Corporation : ****
 # Description : toast 弹窗
 ******************************************************************************/

import UIKit
import Toaster

class KCToaster: Any {
    static func show(_ msg: String) {
        if let current = ToastCenter.default.currentToast {
            current.cancel()
        }

        let toast = Toast(text: DEF_LOCALIZED_STRING(key: msg), duration: 2.0)
        toast.view.bottomOffsetPortrait = 100
        toast.show()
    }
}
