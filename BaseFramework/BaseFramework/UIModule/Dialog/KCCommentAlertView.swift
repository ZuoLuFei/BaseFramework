/*******************************************************************************
 # File        : KCCommentAlertView.swift
 # Project     : Dialog
 # Author      : &&&&
 # Created     : 2018/8/17
 # Corporation : ****
 # Description : 评价弹窗, KCAlertView子类
 ******************************************************************************/

import UIKit

class KCCommentAlertView: KCAlertView {
    static func show() {
        let instance = KCCommentAlertView(title: "交易评价", icon: "alertComment", actions: ["取消", "确认"], specialIndex: 1, complection: nil)
        instance.show()
    }

    override func initMidContent() {
        let midContainer = UIView(frame: CGRect(x: 38, y: contentHeight + 20, width: contentView.bounds.size.width - 76, height: 65))
        contentView.addSubview(midContainer)

        let datas = [("alertHappy", "好评"), ("alertNeutral", "中评"), ("alertSad", "差评")]
        var items = [UIBarButtonItem]()
        for (index, data) in datas.enumerated() {
            items.append(_constructActionBtn(data.0, data.1))
            guard index != datas.count - 1 else { break }
            items.append(UIBarButtonItem.flexibleItem())
        }

        let toolbar = UIToolbar(frame: midContainer.bounds)
        toolbar.items = items
        toolbar.clearBackground()
        midContainer.addSubview(toolbar)

        contentHeight += 85
    }

    private func _constructActionBtn(_ icon: String, _ title: String) -> UIBarButtonItem {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 65))

        let iconIV = UIImageView(image: UIImage(named: icon))
        iconIV.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        container.addSubview(iconIV)

        let titleLab = UILabel(frame: CGRect(x: 0, y: 44, width: 32, height: 21))
        titleLab.text = title
        titleLab.textColor = UIColor.hex(value: 0x677282)
        titleLab.font = UIFont.pingFangWith(size: 15)
        container.addSubview(titleLab)

        let item = UIBarButtonItem(title: nil, style: .plain, target: self, action: #selector(_clickComment(_:)))
        item.customView = container
        return item
    }

    @objc private func _clickComment(_ item: UIBarButtonItem) {
    }
}
