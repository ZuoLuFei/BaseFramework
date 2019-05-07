/*******************************************************************************
 # File        : KCNetWorkEnvironment.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/7/11
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

enum KCNetWorkEnvironment: Int {
    case release = 0  // 发布环境
    case sit = 1      // SIT环境
    case dev = 2      // DEV环境
    case qa = 3       // 测试环境

    var url: String {
        switch self {
        case .release:
            return "https://kitchen.kcs.top/"
        case .sit:
            return "https://kitchen.kucoin.net/"
        case .dev:
            return "http://192.168.17.19:8080/app/"
        case .qa:
            return "http://192.168.17.29:8080/app/"
        }
    }

}
