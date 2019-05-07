/*******************************************************************************
 # File        : KCListAlertView.swift
 # Project     : Dialog
 # Author      : &&&&
 # Created     : 2018/8/17
 # Corporation : ****
 # Description : 列表alert弹窗
 ******************************************************************************/

import UIKit

class KCListAlertView: KCAlertView {

    private var datas: [String] = []

    /**
     * 显示列表弹窗
     * @params
     * datas: 要显示的列表数据
     * 其他参数参看父类
     */
    static func show(title: String,
                     datas: [String] = [],
                     icon: String? = nil,
                     actions: [String]? = nil,
                     specialIndex: Int = -1,
                     complection: ((_ index: Int) -> Void)? = nil) {

        let instance = self.init(title: title,
                                 icon: icon,
                                 actions: actions,
                                 specialIndex: specialIndex,
                                 complection: complection)
        instance.datas = datas
        instance.show()
    }

    override func initMidContent() {
        let width = contentView.bounds.size.width - 32
        contentHeight += 16
        for data in datas {
            let itemView = _constructItem(data, width)
            var frame = itemView.frame
            frame.origin.x = 16
            frame.origin.y = contentHeight
            itemView.frame = frame
            contentView.addSubview(itemView)

            contentHeight += (frame.size.height + 4)
        }
    }

    private func _constructItem(_ content: String, _ width: CGFloat) -> UIView {
        let container = UIView()

        let dot = UIView()
        dot.backgroundColor = UIColor.hex(value: 0xC6CDD9)
        dot.layer.cornerRadius = 3
        dot.frame = CGRect(x: 0, y: 8, width: 6, height: 6)
        container.addSubview(dot)

        let contentLab = UILabel()
        contentLab.numberOfLines = 0
        container.addSubview(contentLab)

        let attrStr = NSMutableAttributedString(string: content,
                                                attributes: [.font: UIFont.pingFangWith(size: 15), .foregroundColor: UIColor.hex(value: 0x677282)])
        contentLab.attributedText = attrStr

        let height = attrStr.boundingRect(with: CGSize(width: width - 12, height: 200),
                                          options: [.usesLineFragmentOrigin], context: nil).size.height
        contentLab.frame = CGRect(x: 12, y: 0, width: width - 12, height: height)

        container.frame = CGRect(x: 0, y: 0, width: width, height: height)
        return container
    }
}
