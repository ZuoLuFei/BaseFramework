/*******************************************************************************
 # File        : KCRequestManager.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/12
 # Corporation : ****
 # Description : 请求中心
 ******************************************************************************/

import UIKit

class KCRequestManager<T: KCResponseFilterProtocol>: NSObject {

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
    /// - Returns: Cancellable 用户取消请求任务
    @discardableResult
    static func get(baseUrl: String? = KCGlobalSwitch.networkEnv.url,
                    url: String,
                    params: [String: Any]?,
                    startShow: Bool? = false,
                    endShow: Bool? = false,
                    logger: Bool? = true,
                    complection: ((_ data: Any?, _ error: KCError?) -> Void)?) -> Cancellable {

        let target: KCNetworkTargetType = .get(baseUrl:baseUrl,
                                          url: url,
                                          parameters: params,
                                          startShow: startShow ?? false,
                                          endShow: endShow ?? false,
                                          logger:logger ?? false)
        return KCNetWorkCenter<T>().request(target: target, success: { (data) in
            complection?(data, nil)
        }, failure: { (error) in
            complection?(nil, error)
        })
    }

    /// post请求 请求参数以form表单方式提交
    ///
    /// - Parameters:
    ///   - baseUrl: 特殊baseUrl,默认为系统baseUrl
    ///   - url: 请求Url
    ///   - params: 请求参数
    ///   - startShow: 是否显示请求Loading , 默认为false
    ///   - endShow: 是否隐藏请求Loading , 默认为false
    ///   - logger: 是否打印请求参数及返回数据 , 默认为true
    ///   - complection: 数据回调
    /// - Returns: Cancellable 用户取消请求任务
    @discardableResult
    static func post(baseUrl: String? = KCGlobalSwitch.networkEnv.url,
                     url: String,
                     params: [String: Any]?,
                     parameType: KCPostParameType = .parameters,
                     startShow: Bool? = false,
                     endShow: Bool? = false,
                     logger: Bool? = true,
                     complection: ((_ data: Any?, _ error: KCError?) -> Void)?) -> Cancellable {
        let target: KCNetworkTargetType = .post(baseUrl:baseUrl,
                                           url: url,
                                           parameters: params,
                                           parameType: parameType,
                                           startShow: startShow ?? false,
                                           endShow: endShow ?? false,
                                           logger:logger ?? false)
        return KCNetWorkCenter<T>().request(target: target, success: { (data) in
            complection?(data, nil)
        }, failure: { (error) in
            complection?(nil, error)
        })
    }
}

class KCNormalRequestManager: KCRequestManager<KCCommonResponseFilter> {}
