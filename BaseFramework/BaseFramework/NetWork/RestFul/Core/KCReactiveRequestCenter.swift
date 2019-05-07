/*******************************************************************************
 # File        : KCReactiveRequestCenter.swift
 # Project     : &&&&
 # Author      : shenghai
 # Created     : 2018/9/29
 # Corporation : ****
 # Description : Reactive请求中心
 -------------------------------------------------------------------------------
 # Date        :
 # Author      :
 # Notes       :
 ******************************************************************************/

import UIKit

class KCReactiveRequestCenter<T: KCResponseFilterProtocol>: NSObject {
    /// get请求
    ///
    /// - Parameters:
    ///   - baseUrl: 特殊baseUrl,默认为系统baseUrl
    ///   - url: 请求Url
    ///   - params: 请求参数
    ///   - startShow: 是否显示请求Loading , 默认为false
    ///   - endShow: 是否隐藏请求Loading , 默认为false
    ///   - logger: 是否打印请求参数及返回数据 , 默认为true
    ///   - complection: 数据回调
    /// - Returns:
    @discardableResult
    static func rxGet(baseUrl: String? = KCGlobalSwitch.networkEnv.url,
                      url: String,
                      params: [String: Any]?,
                      startShow: Bool? = false,
                      endShow: Bool? = false,
                      logger: Bool? = true) -> Observable<Any?> { // Cancellable

        return KCNetWorkCenter<T>()
            .rxRequest(target: .get(baseUrl:baseUrl, url: url, parameters: params, startShow: startShow!, endShow: endShow!, logger:logger!))
    }

    /// post请求
    ///
    /// - Parameters:
    ///   - baseUrl: 特殊baseUrl,默认为系统baseUrl
    ///   - url: 请求Url
    ///   - params: 请求参数
    ///   - startShow: 是否显示请求Loading , 默认为false
    ///   - endShow: 是否隐藏请求Loading , 默认为false
    ///   - logger: 是否打印请求参数及返回数据 , 默认为true
    /// - Returns:
    @discardableResult
    static func rxPost(baseUrl: String? = KCGlobalSwitch.networkEnv.url,
                       url: String,
                       params: [String: Any]?,
                       startShow: Bool? = false,
                       endShow: Bool? = false,
                       logger: Bool? = true) -> Observable<Any?> {
        return KCNetWorkCenter<T>()
            .rxRequest(target: .post(baseUrl:baseUrl, url: url, parameters: params, parameType: .parameters, startShow: startShow!, endShow: endShow!, logger:logger!))
    }

    static func test(baseUrl: String? = KCGlobalSwitch.networkEnv.url,
                     url: String,
                     params: [String: Any]?,
                     parameType: KCPostParameType = .parameters,
                     startShow: Bool? = false,
                     endShow: Bool? = false,
                     logger: Bool? = true) -> Observable<KCResponse?> { //
        return KCNetWorkCenter<T>()
            .test(target: .post(baseUrl:baseUrl, url: url, parameters: params, parameType:parameType, startShow: startShow!, endShow: endShow!, logger:logger!))

    }
}

class KCRxRequestCenter: KCReactiveRequestCenter<KCRxResponseFilter> {
}
