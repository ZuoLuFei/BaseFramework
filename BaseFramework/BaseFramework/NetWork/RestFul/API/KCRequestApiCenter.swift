/*******************************************************************************
 # File        : KCRequestApiCenter.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/6/28
 # Corporation : ****
 # Description : Api中心
 ******************************************************************************/

import UIKit
import Moya

class KCRequestApiCenter: NSObject {

    /// 获取语言列表
    @discardableResult
    class public func requestOpenLanglist(_ startShow: Bool, complection: ((_ data: Any?, _ error: KCError?) -> Void)?) -> Cancellable {
        return KCNormalRequestManager.get(url: "v1/open/lang-list", params: nil, complection: complection)
    }
}
