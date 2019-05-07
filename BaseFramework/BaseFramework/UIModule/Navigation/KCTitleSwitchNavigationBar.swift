/*******************************************************************************
 # File        : KCTitleSwitchNavigationBar.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/8/21
 # Corporation : ****
 # Description : 标题切换工具bar视图
 ******************************************************************************/

import UIKit

class KCTitleSwitchNavigationBar: UIView {
    private var titles: [String] = []
    private var items: [UIButton] = []

    // 切换选中的标题回调
    private var switchBlock: ((_ index: Int) -> Void)?

    /**
     * 初始化方法
     * @params:
     * titles: 显示的标题
     * switchBlock: 标题切换事件
     */
    init(titles: [String], switchBlock: ((_ index: Int) -> Void)?) {
        super.init(frame: CGRect.zero)
        self.titles = titles
        self.switchBlock = switchBlock
        _initUI()
        self.update(0)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /**
     * 暴露的外部切换标题的方法
     * @params
     * index: 要切换到的标题的下标
     */
    func update(_ index: Int) {
        for (i, item) in items.enumerated() {
            item.setTitleColor(UIColor.hex(value: i == index ? 0x0F7DFF : 0x929FB3),
                               for: .normal)
        }
    }

    private func _initUI() {
        self.backgroundColor = UIColor.white

        let titleView = UIView()
        self.addSubview(titleView)
        titleView.snp.makeConstraints { (make) in
            make.top.equalTo(Screen.statusBarHeight)
            make.bottom.equalTo(0)
            make.width.equalTo(150)
            make.centerX.equalTo(self.snp.centerX)
        }

        for (i, title) in titles.enumerated() {
            let actionBtn = UIButton()
            actionBtn.setTitle(title, for: .normal)
            actionBtn.setTitleColor(UIColor.hex(value: 0x929FB3), for: .normal)
            actionBtn.titleLabel?.font = UIFont.pingFangWith(size: 18)
            actionBtn.tag = i
            actionBtn.addTarget(self, action: #selector(_handleClick(_:)), for: .touchUpInside)
            titleView.addSubview(actionBtn)

            items.append(actionBtn)
        }

        for (i, item) in items.enumerated() {
            if i == 0 {
                item.snp.makeConstraints { (make) in
                    make.leading.top.bottom.equalTo(0)
                }
            } else {
                item.snp.makeConstraints { (make) in
                    make.top.bottom.equalTo(0)
                    make.leading.equalTo(items[i - 1].snp.trailing)
                    make.width.equalTo(items[i - 1].snp.width)
                }

                if i == items.count - 1 {
                    item.snp.makeConstraints { (make) in
                        make.trailing.equalTo(0)
                    }
                }
            }
        }

        let split = UIView()
        split.backgroundColor = UIColor.hex(value: 0xEFF2F9)
        self.addSubview(split)
        split.snp.makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(0)
            make.height.equalTo(1)
        }
    }

    @objc private func _handleClick(_ btn: UIButton) {
        switchBlock?(btn.tag)
    }
}
