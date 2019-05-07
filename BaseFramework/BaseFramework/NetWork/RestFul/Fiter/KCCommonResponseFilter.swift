/*******************************************************************************
 # File        : KCCommonResponseFilter.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/7/18
 # Corporation : ****
 # Description : 网络请求公共过滤层
 ******************************************************************************/

import UIKit
import Moya
import ObjectMapper

class KCCommonResponseFilter: KCResponseFilterProtocol {
    class func filter(_ result: Moya.Response, success: SuccessBlock?, failure: FailureBlock?) {
        guard let jsonData = try? result.mapJSON(),
            let response = Mapper<KCResponse>().map(JSONObject: jsonData) else {

                failure?(KCError(code: "111", msg: "未知错误"))
                return
        }
        // 这里Toast显示header中的验证码 后期要删除掉
        if let code = result.response?.allHeaderFields["VALIDATION-CODE"] as? String {
            KCToaster.show(code)
        }

        if response.success || response.code == kNetworkSuccessCode {
            if response.data != nil { // model类型数据
                success?(response.data)
            } else if let arrayData = response.items { // array 类型数据
                var responseArray: [String: Any] = [:]
                responseArray["items"] = arrayData
                responseArray["currentPage"] = response.currentPage
                responseArray["pageSize"] = response.pageSize
                responseArray["totalPage"] = response.totalPage
                responseArray["currentPage"] = response.currentPage
                success?(responseArray)
            } else {
                success?(nil)
            }
        } else {
            failure?(KCError(code: response.code, msg: response.msg))
        }
    }
}
