/*******************************************************************************
 # File        : UILabel+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

extension UILabel {
    /**
     * 设置UILabel文字行间距
     */
    func setRowSpaceing(_ spacing: CGFloat) {
        guard let content = self.text else {return}
        assert(content.count > 0, "你还没有设置label的text呢")
        let attributedString = NSMutableAttributedString(string: content)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: content.count))
        self.attributedText = attributedString
    }

    /**
     *  文字富文本字体设置
     *
     *  @param text       需要处理的文字
     *  @param scaleTexts 需要处理字体的文字
     *  @param scaleFonts 文字字体
     *  @param diffColors 文字颜色
     */
    func setAttrText(text: String, scaleTexts: [String], scaleFonts: [UIFont], diffColors: [UIColor]) {
        assert(text.count > 0, "你还没有设置label的text呢")
        self.text = text
        let attributedString = NSMutableAttributedString(string: text)
        for scaleText in scaleTexts {
            let index = scaleTexts.index(of: scaleText) ?? 0
            if scaleFonts.count > index {
                attributedString.addAttribute(.font, value: scaleFonts[index], range: NSRange.init(text.range(of: scaleText)!, in: text))
            }
            if diffColors.count > index {
                attributedString.addAttribute(.foregroundColor, value: diffColors[index], range: NSRange.init(text.range(of: scaleText)!, in: text))
            }
        }
        self.attributedText = attributedString
    }
}
