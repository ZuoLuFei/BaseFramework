/*******************************************************************************
 # File        : KCKLineResponseFilter.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/10/12
 # Corporation : ****
 # Description : K线图网络过滤层
 ******************************************************************************/

import UIKit

class KCKLineResponseFilter: KCResponseFilterProtocol {

    class func filter(_ result: Moya.Response, success: SuccessBlock?, failure: FailureBlock?) {

        do {
            // 解析数据
            let mapResult = try result.mapJSON()
            let json = JSON(mapResult).dictionaryObject
            success?(json)
        } catch {
            failure?(KCError(code: "111", msg: "未知错误"))
        }
    }
}
