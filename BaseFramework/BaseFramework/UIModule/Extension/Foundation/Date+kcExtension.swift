/*******************************************************************************
 # File        : Date+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import Foundation

extension Date {
    var yyyyMMdd: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }

    var HHmmss: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter.string(from: self)
    }

    var yyMMddHHmm: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd HH:mm"
        return formatter.string(from: self)
    }

    var MMdd: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd"
        return formatter.string(from: self)
    }

    var HHmm: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}
