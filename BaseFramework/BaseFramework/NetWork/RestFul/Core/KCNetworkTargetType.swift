/*******************************************************************************
 # File        : KCNetworkTargetType.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/7/11
 # Corporation : ****
 # Description : KCNetworkTargetType
 ******************************************************************************/

import UIKit
import Moya
import Result

enum KCPostParameType {
    case parameters
    case data
}

enum KCNetworkTargetType: TargetType {
    case get(baseUrl: String?, url: String, parameters: [String: Any]?, startShow: Bool, endShow: Bool, logger: Bool)
    case post(baseUrl: String?, url: String, parameters: [String: Any]?, parameType: KCPostParameType, startShow: Bool, endShow: Bool, logger: Bool)

    /// 基础域名
    var baseURL: URL {
        switch self {
        case let .get(baseUrl: baseUrl, url: _, parameters: _, startShow:_, endShow:_, logger:_):
            let url = baseUrl ?? KCGlobalSwitch.networkEnv.url
            return URL(string: url)!
        case let .post(baseUrl: baseUrl, url: _, parameters: _, parameType: _, startShow:_, endShow:_, logger:_):
            let url = baseUrl ?? KCGlobalSwitch.networkEnv.url
            return URL(string: url)!
        }
    }

    /// 接口地址
    var path: String {
        switch self {
        case let .get(baseUrl: _, url: path, parameters: _, startShow:_, endShow:_, logger:_):
            return path
        case let .post(baseUrl: _, url: path, parameters: _, parameType: _, startShow:_, endShow:_, logger:_):
            return path
        }
    }

    /// 方法
    var method: Moya.Method {
        switch self {
        case .get:
            return .get
        case .post:
            return .post
        }
    }

    /// 这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8) ?? Data()
    }

    /// 请求任务
    var task: Task {
        switch self {
        case let .get(baseUrl: _, url: _, parameters: parameters, startShow: _, endShow: _, logger: _):

            guard let params = parameters else { return .requestPlain }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)

        case let .post(baseUrl: _, url: _, parameters: parameters, parameType: parameType, startShow:_, endShow:_, logger:_):

            guard let params = parameters else { return .requestPlain }
            if parameType == .parameters {
                return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            } else {
                // todo: 待完善
                return .requestData(params.jsonData() ?? Data())
            }
        }
    }

    /// 请求头
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }

    /// 以下两个参数是自定义，用来控制网络加载的时候是否允许操作和是否要显示加载提示，这两个参数在自定义插件的时候会用到
    var startShow: Bool { //开始网络请求时是否显示转圈提示
        switch self {
        case let .get(baseUrl: _, url: _, parameters: _, startShow: startShow, endShow: _, logger: _):
            return startShow
        case let .post(baseUrl: _, url: _, parameters: _, parameType: _, startShow: startShow, endShow: _, logger: _):
            return startShow
        }
    }

    var endShow: Bool { //结束网络请求时是否取消转圈提示
        switch self {
        case let .get(baseUrl: _, url: _, parameters: _, startShow: _, endShow: endShow, logger: _):
            return endShow
        case let .post(baseUrl: _, url: _, parameters: _, parameType: _, startShow: _, endShow: endShow, logger: _):
            return endShow
        }
    }
}
