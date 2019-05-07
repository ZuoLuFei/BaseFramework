/*******************************************************************************
 # File        : KCRxResponseFilter.swift
 # Project     : &&&&
 # Author      : shenghai
 # Created     : 2018/10/26
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

enum HomeworkError: Int, Error {
    case forgotten
    case lost
    case dogAteIt
}

class KCRxResponseFilter: KCResponseFilterProtocol {

    static func rxFilter(_ result: Moya.Response, data: inout Any?, error: inout KCError?) {
        guard let jsonData = try? result.mapJSON(),
            let response = Mapper<KCResponse>().map(JSONObject: jsonData) else {

                error = KCError(code: "111", msg: "未知错误")
                return
        }
        // 这里Toast显示header中的验证码 后期要删除掉
        if let code = result.response?.allHeaderFields["VALIDATION-CODE"] as? String {
            KCToaster.show(code)
        }

        if response.success || response.code == kNetworkSuccessCode {
            if response.data != nil { // model类型数据
                data = response.data
            } else if let arrayData = response.items { // array 类型数据
                var responseArray: [String: Any] = [:]
                responseArray["items"] = arrayData
                responseArray["currentPage"] = response.currentPage
                responseArray["pageSize"] = response.pageSize
                responseArray["totalPage"] = response.totalPage
                responseArray["currentPage"] = response.currentPage
                data = responseArray
            } else {
                data = nil
            }
        } else {
            error = KCError(code: response.code, msg: response.msg)
        }
    }
}
