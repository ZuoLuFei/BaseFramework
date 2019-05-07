/*******************************************************************************
 # File        : KCFuctionDefinition.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/6/12
 # Corporation : ****
 # Description : 方法常量
 ******************************************************************************/

import UIKit

struct Screen {
    //当前屏幕尺寸
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let navigationBarHeight = UIApplication.shared.statusBarFrame.height + 44
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    static let size = UIScreen.main.bounds.size

    //设备相关
    static var isIphone4Or4s: Bool {
        return self._checkDeviceSize(640, 960)
    }

    static var isIphone5Or5s: Bool {
        return self._checkDeviceSize(640, 1136)
    }

    static var isIphone678: Bool {
        return self._checkDeviceSize(750, 1334)
    }

    static var isIphone678Plus: Bool {
        return self._checkDeviceSize(1242, 2208)
    }

    static var isIphoneX: Bool {
        return Screen.height > 736
    }

    private static func _checkDeviceSize(_ width: CGFloat, _ height: CGFloat) -> Bool {
        if let size = UIScreen.main.currentMode?.size {
            return __CGSizeEqualToSize(CGSize(width: width, height: height), size)
        }
        return false
    }

    static var bottomDangerAreaHeight: CGFloat {
        return Screen.isIphoneX ? 34 : 0
    }

    static func kLMS(_ l: CGFloat, _ m: CGFloat, _ s: CGFloat) -> CGFloat {
        if isIphone678Plus {
            return l
        } else if isIphone678 {
            return m
        } else if isIphone5Or5s {
            return s
        } else {
            return s
        }
    }
}

// MARK: - 设备相关
struct Device {
    static var isIOS7OrLater: Bool {
        return isSystemThan(version: 7)
    }

    static var isIOS8OrLater: Bool {
        return isSystemThan(version: 8)
    }

    static var isIOS9OrLater: Bool {
        return isSystemThan(version: 9)
    }

    static var isIOS10OrLater: Bool {
        return isSystemThan(version: 10)
    }

    static var isIOS11OrLater: Bool {
        return isSystemThan(version: 11)
    }

    static func isSystemThan(version: Float) -> Bool {
        return (UIDevice.current.systemVersion.float() ?? 0) >= version
    }
}

// MARK: - 国际化匹配
///// 国际化匹配
//func DEF_LOCALIZED_STRING(key: String) -> String {
//    return (KCLocalizableManager.shareInstance.bundle?.localizedString(forKey: key, value: nil, table: nil))!
//}

// MARK: - UserDefaults相关

extension UserDefaults {
    static func objectForKey(_ key: String) -> Any? {
        return UserDefaults.standard.object(forKey: key)
    }

    static func setAndSaveObject(_ value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }

    static func removeObjectForKey(_ key: String) {
        UserDefaults.standard.removeObject(forKey: key)
        UserDefaults.standard.synchronize()
    }
}

// MARK: 自定义颜色

extension UIColor {
    /// 生成RGB颜色
    ///
    /// - Parameters:
    ///   - red: red值（0~255）
    ///   - green: green值（0~255）
    ///   - blue: blue值（0~255）
    /// - Returns: UIColor对象
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red / 255.0), green: CGFloat(green / 255.0), blue: CGFloat(blue / 255.0), alpha: 1)
    }

    /// 生成RGBA颜色
    ///
    /// - Parameters:
    ///   - red: red值（0~255）
    ///   - green: green值（0~255）
    ///   - blue: blue值（0~255）
    ///   - alpha: blue值（0~1）
    /// - Returns: UIColor对象
    static func rgbaColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: CGFloat(red / 255.0), green: CGFloat(green / 255.0), blue: CGFloat(blue / 255.0), alpha: alpha)
    }

    /// 随机色
    static func randomColor() -> UIColor {
        return self.rgbColor(red: CGFloat(arc4random()%256), green: CGFloat(arc4random()%256), blue: CGFloat(arc4random()%256))
    }
}
