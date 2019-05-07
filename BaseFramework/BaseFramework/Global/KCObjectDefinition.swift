/*******************************************************************************
 # File        : KCObjectDefinition.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/6/28
 # Corporation : ****
 # Description : 全局对象常亮
 ******************************************************************************/

import UIKit

struct Constant {
    /// 全局cell边距
    static let cellMargin: CGFloat = 12

    /// 币种图片URL
    static func coinImageUrl(_ coin: String) -> URL? {
        return URL(string: "https://assets.kucoin.com/www/coin/pc/\(coin).png")
    }
}
