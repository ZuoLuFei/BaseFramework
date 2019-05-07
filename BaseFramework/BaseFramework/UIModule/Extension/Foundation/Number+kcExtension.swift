/*******************************************************************************
 # File        : Double+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import Foundation

extension Double {
    var defaultPrecisionString: String {
        return String(format: "%.8f", self)
    }

    /**
     * 精度
     */
    var precision: Int {
        let valueArr = String(format: "%.8f", self).deleteLastChar("0").split(separator: ".")
        if valueArr.count > 1 {
            return valueArr[1].count
        } else {
            return 1
        }
    }

    func toString(_ precision: Int) -> String {
        return String(format: "%.\(precision)f", self)
    }

    /**
     转化为字符串格式

     - parameter minF:
     - parameter maxF:
     - parameter minI:

     - returns:
     */
    func toString(_ minF: Int = 0, maxF: Int = 10, minI: Int = 1) -> String {
        let valueDecimalNumber = NSDecimalNumber(value: self)
        let twoDecimalPlacesFormatter = NumberFormatter()
        twoDecimalPlacesFormatter.maximumFractionDigits = maxF
        twoDecimalPlacesFormatter.minimumFractionDigits = minF
        twoDecimalPlacesFormatter.minimumIntegerDigits = minI
        return twoDecimalPlacesFormatter.string(from: valueDecimalNumber)!
    }
}
