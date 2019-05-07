/*******************************************************************************
 # File        : String+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import Foundation

let salt = "_kucoin_"

extension String {

    /// 判断字符串是否为空
    ///
    /// - Parameter string: 待判断字符串
    /// - Returns: true非空，false空
    static func isNotBlankString(_ string: String?) -> Bool {
        return !String.isBlankString(string)
    }

    /// 判断字符串是否为空
    ///
    /// - Parameter string: 待判断字符串
    /// - Returns: true空，false非空
    static func isBlankString(_ string: String?) -> Bool {

        guard let str = string else {
            return true
        }

        guard str.isKind(of: NSString.self) else {
            return true
        }

        guard !str.isKind(of: NSNull.self) else {
            return true
        }

        guard str.trimmingCharacters(in: NSCharacterSet.whitespaces).count != 0 else {
            return true
        }

        guard !str.isEqual("(null)") else {
            return true
        }

        guard !str.isEqual("null") else {
            return true
        }

        guard !str.isEqual("<null>") else {
            return true
        }

        return false
    }

    var isEmpty: Bool {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces).count < 1
    }

    /**
     * 字符串转出指定精度的double
     */
    func validDoubleWith(_ precision: Int) -> Double? {
        var newValue = self
        let arr = self.components(separatedBy: ".")
        if arr.count > 1 {
            if arr[1].count > precision {
                newValue = "\(arr[0]).\(NSString(string: arr[1]).substring(to: precision))"
            } else if arr[1].count == 0 {
                newValue = arr[0]
            } else {
                newValue = "\(arr[0]).\(arr[1])"
            }
        }

        return newValue.double()
    }

    func validDoubleStr(_ precision: Int) -> String {
        var newValue = self
        let arr = self.components(separatedBy: ".")
        if arr.count > 1 {
            if arr[1].count > precision {
                newValue = "\(arr[0]).\(NSString(string: arr[1]).substring(to: precision))"
            } else {
                newValue = "\(arr[0]).\(arr[1])"
            }
        }
        return newValue
    }

    /**
     * 删除原有字符串的末尾特定字符
     */
    func deleteLastChar(_ target: Character) -> String {
        let cArr = self.charactersArray
        var index = cArr.count
        while index > 0 && cArr[index - 1] == target {
            index -= 1
        }

        var newStr = self
        newStr.slice(from: 0, to: index)
        return newStr
    }

    /**
     * 复制当前字符串到剪切板
     */
    func copyToPasteboard() {
        UIPasteboard.general.string = self
    }
}

/*
 * 拼音码转换扩展
 */
extension String {

    func transformToPinYin() -> String {

        let mutableString = NSMutableString(string: self)
        //把汉字转为拼音
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        //去掉拼音的音标
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)

        let string = String(mutableString)
        //去掉空格
        return string.replacingOccurrences(of: " ", with: "").lowercased()
    }
}

/*
 * 计算文字宽高扩展
 */
extension String {

    func heightForComment(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedStringKey.font: font], context: nil)
        return boundingBox.height
    }

    func widthForComment(height: CGFloat = 20, font: UIFont) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT),
                                                                    height: height),
                                                       options: .usesLineFragmentOrigin,
                                                       attributes: [NSAttributedStringKey.font: font],
                                                       context: nil)
        return ceil(rect.width)
    }
}

/*
 * 正则表达式扩展
 */
extension String {
    static let kPasswordErrorMsg = "7～32位字符，必须包含大小写字母和数字"
    static let kEmailErrorMsg = "无效邮件地址"

    var isValidEmail: Bool {
        return self.matches(pattern: "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$")
    }

    var isValidPassword: Bool {
        return self.matches(pattern: "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z]).{7,32}$")
    }
}

///*
// * sha256扩展
// */
//extension String {
//    func sha256() -> String {
//        if let stringData = self.data(using: String.Encoding.utf8) {
//            return hexStringFromData(input: digest(input: stringData as NSData))
//        }
//        return ""
//    }
//    private func digest(input: NSData) -> NSData {
//        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
//        var hash = [UInt8](repeating: 0, count: digestLength)
//        CC_SHA256(input.bytes, UInt32(input.length), &hash)
//        return NSData(bytes: hash, length: digestLength)
//    }
//    private  func hexStringFromData(input: NSData) -> String {
//        var bytes = [UInt8](repeating: 0, count: input.length)
//        input.getBytes(&bytes, length: input.length)
//        var hexString = ""
//        for byte in bytes {
//            hexString += String(format: "%02x", UInt8(byte))
//        }
//        return hexString.uppercased()
//    }
//
//    private func md5() -> String {
//        let str = self.cString(using: String.Encoding.utf8)
//        let strLen = CUnsignedInt(self.lengthOfBytes(using: String.Encoding.utf8))
//        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
//        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: 16)
//        CC_MD5(str!, strLen, result)
//        let hash = NSMutableString()
//        for i in 0 ..< digestLen {
//            hash.appendFormat("%02x", result[i])
//        }
//        free(result)
//        return String(format: hash as String)
//    }
//
//    // 登录密码MD5 加盐  规则 MD5(SALT + MD5(SALT + MD5(SALT + PASSWORD + SLAT) + SALT) + SALT)
//    func pwdMd5() -> String {
//        let firstStep = (salt + self + salt).md5()
//        let secondStep = (salt + firstStep + salt).md5()
//        let thirdStep = (salt + secondStep + salt).md5()
//        return thirdStep
//    }
//}
