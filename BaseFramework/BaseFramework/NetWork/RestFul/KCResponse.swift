/*******************************************************************************
 # File        : KCResponse.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/6/13
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit
import ObjectMapper

let kNetworkSuccessCode = "200"

class KCResponse: Mappable {
    var success: Bool = false   /// 请求是否成功
    var code: String?           /// 返回码
    var timestamp: String?      /// 时间戳
    var msg: String?            /// 返回信息

    var data: Any?              /// 返回model
    var items: [Any]? /// 返回数组

    var retry: Bool = false
    var totalNum: Int = 0
    var totalPage: Int = 0
    var currentPage: Int = 0
    var pageSize: Int = 0

    required init?(map: Map) {}

    func mapping(map: Map) {
        success     <- map["success"]
        code        <- map["code"]
        timestamp   <- map["timestamp"]
        msg         <- map["msg"]
        data        <- map["data"]
        items       <- map["items"]

        retry       <- map["retry"]
        totalNum    <- map["totalNum"]
        totalPage   <- map["totalPage"]
        currentPage <- map["currentPage"]
        pageSize    <- map["pageSize"]
    }
}

class KCError: Error {
    var code = ""     // 返回错误码
    var message = ""  // 返回错误信息

    init(code: String? = "", msg: String? = "") {
        self.code = code ?? ""
        self.message = msg ?? ""
    }
}
