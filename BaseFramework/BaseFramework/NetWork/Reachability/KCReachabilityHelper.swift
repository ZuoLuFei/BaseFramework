/*******************************************************************************
 # File        : KCReachabilityHelper.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/8
 # Corporation : ****
 # Description : 网络检测辅助类
 ******************************************************************************/

import UIKit
import Alamofire
import Foundation

enum KCReachabilityType {
    case wifi       // wifi网络
    case cellular   // 蜂窝网
    case none       // 无网络
}

class KCReachabilityHelper: NSObject {
    static let share = KCReachabilityHelper()

    private var _reachability = NetworkReachabilityManager()

    var type = BehaviorRelay(value: KCReachabilityType.none)

    override init() {
        super.init()
        _addNotificationObserver()
    }

    deinit {
        _reachability?.stopListening()
    }

    /// 检测当前网络是否是Wifi
    func checkNetWorkIsWifi() -> Bool {
        return type.value == .wifi
    }

    /// 检测网络是否可用 wifi和cellular 情况下属于可用
    func checkNetWorkIsReachable() -> Bool {
        return type.value == .wifi || type.value == .cellular
    }

    private func _addNotificationObserver() {
        _reachability?.startListening()
        _reachability?.listener = {[weak self] (status) in
            switch status {
            case .notReachable:
                self?.type.accept(.none)
            case .unknown:
                self?.type.accept(.none)
            case .reachable(.ethernetOrWiFi):
                self?.type.accept(.wifi)
            case .reachable(.wwan):
                self?.type.accept(.cellular)
            }
        }
    }
}
