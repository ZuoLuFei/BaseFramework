//
//  AppDelegate.swift
//  BaseFramework
//
//  Created by ZuoLuFei on 2018/11/13.
//  Copyright © 2018 佐路飞. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    weak var mainTabVC: KCMainTabBarViewController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        
        // 设置根控制器
        _setTabbar()
        
        // 开启自动键盘管理
        IQKeyboardManager.shared.enable = true
        
        // 设置图片下载Kingfisher框架相关参数
        _configKingfisher()
        
        return true
    }
    
    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        
        // 清除内存缓存和磁盘缓存
        ImageCache.default.clearDiskCache()
        ImageCache.default.clearMemoryCache()
        
        // 取消所有的下载任务
        KingfisherManager.shared.downloader.cancelAll()
    }
    
    private func _configKingfisher() {
        // 设置内存缓存的大小，默认是0 表示no limit (5M）
        ImageCache.default.maxMemoryCost = 5 * 1024 * 1024
        
        // 磁盘缓存大小，默认0 表示no limit （50 * 1024）
        ImageCache.default.maxDiskCacheSize = 50 * 1024 * 1024
    }

}

extension AppDelegate {
    func _setTabbar() {
        let mainTabVC = KCMainTabBarViewController()
        self.mainTabVC = mainTabVC
        self.window?.rootViewController = mainTabVC
        self.window?.makeKeyAndVisible()
    }
}

