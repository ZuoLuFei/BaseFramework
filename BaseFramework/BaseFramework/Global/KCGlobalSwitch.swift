/*******************************************************************************
 # File        : KCGlobalSwitch.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/12
 # Corporation : ****
 # Description : 全局开关，控制某些特殊属性
 ******************************************************************************/

import UIKit

@_exported import SnapKit
@_exported import SwiftyJSON
@_exported import RxSwift
@_exported import RxCocoa
@_exported import ObjectMapper
@_exported import SwifterSwift
@_exported import RxGesture
@_exported import Then
@_exported import Moya
@_exported import Kingfisher
@_exported import IQKeyboardManagerSwift

struct KCGlobalSwitch {
    // 网络环境配置
    static let networkEnv: KCNetWorkEnvironment = .dev

    /// moya Request打印组件是否开启
    static let moyaLoggerRequestPlugin = false
    /// moya Response打印组件是否开启
    static let moyaLoggerResponsePlugin = false
}
