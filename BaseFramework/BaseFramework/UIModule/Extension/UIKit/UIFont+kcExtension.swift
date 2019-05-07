/*******************************************************************************
 # File        : Array+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

extension UIFont {
    static func pingFangWith(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func pingFangMediumWith(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func pingFangSemiboldWith(size: CGFloat) -> UIFont {
        return UIFont(name: "PingFangSC-Semibold", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
