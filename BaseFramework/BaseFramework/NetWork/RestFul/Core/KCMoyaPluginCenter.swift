/*******************************************************************************
 # File        : KCMoyaPluginCenter.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/7/18
 # Corporation : ****
 # Description : Moya插件中心
 ******************************************************************************/

import UIKit
import Moya
import Result

// MARK: - Moya插件中心
struct KCMoyaPluginCenter {

    static let shareMoyaPluginCenter = KCMoyaPluginCenter()

    // 网络过滤层组件
    let myNetWorkFilterPlugin = NetworkActivityPlugin { (state, target) in

        guard let api = target as? KCNetworkTargetType else {
            return
        }

        if state == .began {
            Thread.changeToMainThread({
                if api.startShow {
                    HUD.showLoading()
                }

                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            })
        } else {
            Thread.changeToMainThread({
                if api.endShow {
                    HUD.dismissHUD()
                }

                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
        }
    }

    // 对请求参数做修改
    static let myEndpointClosure = { (target: KCNetworkTargetType) -> Endpoint in

        let url = target.baseURL.appendingPathComponent(target.path).absoluteString

        switch target {
        case let .get(baseUrl: _,
                      url: realUrl,
                      parameters: realParameter,
                      startShow: realStartShow,
                      endShow: realEndShow,
                      logger: realLogger):

            if KCGlobalSwitch.moyaLoggerRequestPlugin && realLogger {

                KCLog.info("\n------------Moya.Request Start Log------------")

                KCLog.info("\n Moya.Request:\n header -- \(JSON(target.headers as Any))\n requesttype -- GET\n url -- \(url)\n paramete -- \(JSON(realParameter as Any))\n")

                KCLog.info("------------Moya.Request End Log------------")
            }

        case let .post(baseUrl: _,
                       url: realUrl,
                       parameters: realParameter,
                       parameType: realparameType,
                       startShow: realStartShow,
                       endShow: realEndShow,
                       logger: realLogger):

            if KCGlobalSwitch.moyaLoggerRequestPlugin && realLogger {

                KCLog.info("\n------------Moya.Request Start Log------------")

                KCLog.info("\n Moya.Request:\n header -- \(JSON(target.headers as Any))\n requesttype -- POST\n url -- \(url)\n paramete -- \(JSON(realParameter as Any))\n")

                KCLog.info("------------Moya.Request End Log------------")
            }
        }

        return Endpoint(
            url: url,
            sampleResponseClosure: {.networkResponse(200, target.sampleData)},
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }

    // 设置请求超时时间
    static let myRequestClosure = { (endpoint: Endpoint, done: @escaping MoyaProvider<KCNetworkTargetType>.RequestResultClosure) in

        guard var request = try? endpoint.urlRequest() else { return }
        request.timeoutInterval = 30    //设置请求超时时间
        var allHeaders = request.allHTTPHeaderFields ?? [:]

        let path = request.url?.path ?? ""
//        if path != "/app//v1/auth/login-validation" ||
//            path != "app//v1/auth/login-validation" ||
//            path != "/app/v1/auth/login-validation" ||
//            path != "app/v1/auth/login-validation" {
//            allHeaders["X-APP-TOKEN"] = KCLoginUser.share.token
//        }
//        allHeaders["Accept-Language"] = KCLanguageManager.share.currentType.value.rawValue
//        allHeaders["X-APP-VERSION"] = SwifterSwift.appVersion ?? "1.0.0"
//        allHeaders["X-DEVICE"] = "iOS sh"
//        allHeaders["X-DEVICE-NO"] = KCLoginUser.share.uuid
//        allHeaders["X-SYSTEM"] = "iOS"
//        allHeaders["X-SYSTEM-VERSION"] = SwifterSwift.systemVersion
//        allHeaders["X-IP"] = "192.168.3.108"
        //allHeaders["X-VERSION"] = "wei"
        request.allHTTPHeaderFields = allHeaders

        done(.success(request))
    }

    // 数据打印组件
//    static let myNetworkLoggerPlugin = NetworkLoggerPlugin(verbose: true, responseDataFormatter: { (data: Data) -> Data in
//        //            return Data()
//        do {
//            let dataAsJSON = try JSONSerialization.jsonObject(with: data)// Data 转 JSON
//            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)// JSON 转 Data，格式化输出。
//            return prettyData
//        } catch {
//            return data
//        }
//    })

}
