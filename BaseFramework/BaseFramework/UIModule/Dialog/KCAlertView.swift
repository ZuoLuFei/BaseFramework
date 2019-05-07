/*******************************************************************************
 # File        : KCAlertView.swift
 # Project     : Dialog
 # Author      : &&&&
 # Created     : 2018/8/16
 # Corporation : ****
 # Description :

 KCAlertView.show(title: "撤单",
                  content: "您确定要撤销此单么?",
                  icon: "alert_revoke",
                  actions: ["取消", "确定"],
                  specialIndex: 1) { (i) in
     print(i)
 }
 ******************************************************************************/

import UIKit

class KCAlertView: KCBaseDialog {

    private var title: String = ""
    private var content: String?
    private var attributeContent: NSAttributedString?
    private var icon: String?
    private var actions: [String] = []
    private var specialIndex: Int = -1
    private var complection: ((_ index: Int) -> Void)?

    /**
     * 用于计算内容区域高度，逐个控件计算累加，作为公开属性，是因为方便子类自定义内容区高度
     */
    var contentHeight: CGFloat = 0

    /**
     * 吊起一个alert 弹窗, title是必填字段，其他是选填，默认为空
     * @params:
     * title: 标题
     * content: 内容
     * attributeContent: 带属性的内容, content 和 attributeContent 互斥，最多填一个
     * icon: 顶部小图标，不传，则会隐藏顶部蓝圈区域
     * actions: 操作按钮数组
     * specialIndex: 使用特殊颜色标识的操作按钮的index
     * complection: 点击操作按钮回调
     */
    static func show(title: String,
                     content: String? = nil ,
                     attributeContent: NSAttributedString? = nil,
                     icon: String? = nil,
                     actions: [String]? = nil,
                     specialIndex: Int = -1,
                     complection: ((_ index: Int) -> Void)? = nil) {

        let instance = self.init(title: title,
                                   content: content,
                                   attributeContent: attributeContent,
                                   icon: icon,
                                   actions: actions,
                                   specialIndex: specialIndex,
                                   complection: complection)
        instance.show()
    }

    required init(title: String,
                  content: String? = nil,
                  attributeContent: NSAttributedString? = nil,
                  icon: String? = nil,
                  actions: [String]? = nil,
                  specialIndex: Int = -1,
                  complection: ((_ index: Int) -> Void)? = nil) {
        super.init()

        self.title = title
        self.content = content
        self.attributeContent = attributeContent
        self.icon = icon
        self.actions = actions ?? []
        self.specialIndex = specialIndex
        self.complection = complection
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func show() {
        _initContentView()
        _initIcon(icon)
        _initTitle(title)
        initMidContent()
        _initActions(actions)

        let screenHeight = UIScreen.main.bounds.size.height
        var frame = contentView.frame
        frame.origin.y = (screenHeight - contentHeight) / 2 + screenHeight
        frame.size.height = contentHeight + 20
        self.contentView.frame = frame

        super.show()
    }

    /**
     * 自定义中间内容区，便于子类集成，扩充显示样式
     */
    func initMidContent() {
        _initContent(content)
        _initAttriContent(attributeContent)
    }

    private func _initContentView() {
        contentView.backgroundColor = UIColor.white
        contentView.layer.cornerRadius = 4
        contentView.frame = CGRect(x: 44,
                                   y: 0,
                                   width: UIScreen.main.bounds.size.width - 88,
                                   height: 0)
    }

    private func _initIcon(_ icon: String?) {
        guard let icon = icon else {
            return
        }

        let containerWidth = contentView.bounds.size.width
        let iconSize: CGFloat = 42
        let iconView = UIView(frame: CGRect(x: (containerWidth - iconSize) / 2,
                                            y: -iconSize / 2,
                                            width: iconSize,
                                            height: iconSize))
        iconView.backgroundColor = UIColor.hex(value: 0x0F7DFF)
        iconView.layer.cornerRadius = iconSize / 2
        contentView.addSubview(iconView)

        let iconIV = UIImageView()
        iconIV.frame = CGRect(x: 10, y: 10, width: 22, height: 22)
        iconIV.image = UIImage(named: icon)
        iconView.addSubview(iconIV)
    }

    private func _initTitle(_ title: String) {
        let titleLab = UILabel()
        titleLab.textColor = UIColor.hex(value: 0x010915)
        titleLab.font = UIFont.pingFangWith(size: 18)
        titleLab.textAlignment = .center
        titleLab.text = title
        contentView.addSubview(titleLab)

        titleLab.frame = CGRect(x: 16,
                                y: 41,
                                width: contentView.bounds.size.width - 32,
                                height: 25)

        contentHeight = 66 // 41 + 25
    }

    private func _initContent(_ content: String?) {
        guard let content = content else { return }

        let font = UIFont.pingFangWith(size: 15)
        let contentLab = UILabel()
        contentLab.textColor = UIColor.hex(value: 0x677282)
        contentLab.font = font
        contentLab.numberOfLines = 0
        contentLab.text = content
        contentView.addSubview(contentLab)

        let height = NSAttributedString(string: content, attributes: [.font: font])
            .boundingRect(with: CGSize(width: contentView.bounds.size.width - 32, height: 500),
                          options: [.usesLineFragmentOrigin],
                          context: nil)
            .size
            .height

        contentLab.frame = CGRect(x: 16,
                                  y: contentHeight + 17,
                                  width: contentView.bounds.size.width - 32,
                                  height: height)

        contentHeight += (height + 17)
    }

    private func _initAttriContent(_ content: NSAttributedString?) {
        guard let content = content else { return }

        let contentLab = UILabel()
        contentLab.numberOfLines = 0
        contentLab.attributedText = content
        contentView.addSubview(contentLab)

        let height = content
            .boundingRect(with: CGSize(width: contentView.bounds.size.width - 32, height: 500),
                          options: [.usesLineFragmentOrigin],
                          context: nil)
            .size
            .height

        contentLab.frame = CGRect(x: 16,
                                  y: contentHeight + 17,
                                  width: contentView.bounds.size.width - 32,
                                  height: height)

        contentHeight += (height + 17)
    }

    private func _initActions(_ actions: [String]?) {
        guard let actions = actions, actions.count > 0 else {
            _initClose()
            return
        }
        self.actions = actions

        let toolbar = UIToolbar(frame: CGRect(x: 16,
                                              y: contentHeight + 12,
                                              width: contentView.bounds.size.width - 32,
                                              height: 46))
        toolbar.clearBackground()

        var items: [UIBarButtonItem] = [UIBarButtonItem.flexibleItem()]

        for (index, action) in actions.enumerated() {
            items.append(_constructActionItem(action, index))
            if index != actions.count - 1 {
                items.append(UIBarButtonItem.emptyItem(CGSize(width: 20, height: 44)))
            }
        }

        toolbar.setItems(items, animated: false)
        contentView.addSubview(toolbar)

        contentHeight += 46 //12 + 22 + 12

        let tap = UITapGestureRecognizer(target: self, action: nil)
        toolbar.addGestureRecognizer(tap)
    }

    private func _constructActionItem(_ action: String, _ index: Int) -> UIBarButtonItem {
        let item = UIBarButtonItem(title: action,
                                   style: .plain,
                                   target: self,
                                   action: #selector(_clickAction(_:)))
        item.tintColor = index == specialIndex ? UIColor.hex(value: 0x0F7DFF) : UIColor.hex(value: 0x929FB3)
        return item
    }

    @objc private func _clickAction(_ item: UIBarButtonItem) {
        guard let title = item.title,
            let index = actions.index(of: title) else { return }
        complection?(index)
        hide()
    }

    // 添加顶部关闭按钮
    private func _initClose() {
        let closeBtn = UIButton()
        closeBtn.setImage(UIImage(named: "alertClose"), for: .normal)
        closeBtn.frame = CGRect(x: contentView.bounds.size.width - 40, y: 0, width: 40, height: 40)
        closeBtn.addTarget(self, action: #selector(hide), for: .touchUpInside)
        contentView.addSubview(closeBtn)
    }

}
