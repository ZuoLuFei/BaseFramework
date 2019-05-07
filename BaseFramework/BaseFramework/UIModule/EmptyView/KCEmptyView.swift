/*******************************************************************************
 # File        : KCEmptyView.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/9/5
 # Corporation : ****
 # Description : 空占位视图，可自定义icon，和刷新事件
 ******************************************************************************/

import UIKit

class KCEmptyView: UIView {
    weak var actionBtn: UIButton!
    weak var arcBgIV: UIImageView!
    weak var textLab: UILabel!
    weak var icon: UIImageView!

    init() {
        super.init(frame: CGRect.zero)
        _initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _initUI() {
        let arcBgIV = UIImageView()
        self.arcBgIV = arcBgIV
        self.addSubview(arcBgIV)
        arcBgIV.snp.makeConstraints { (make) in
            make.width.equalTo(223)
            make.height.equalTo(29)
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(self.snp.centerY).offset(-30)
        }
        arcBgIV.image = #imageLiteral(resourceName: "empty_bg")

        let textLab = UILabel()
        self.textLab = textLab
        self.addSubview(textLab)
        textLab.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(0)
            make.top.equalTo(arcBgIV.snp.bottom).offset(-10)
        }
        textLab.textAlignment = .center
        textLab.font = UIFont.pingFangWith(size: 16)
        textLab.text = "暂无内容"

        let actionBtn = UIButton()
        self.actionBtn = actionBtn
        self.addSubview(actionBtn)
        actionBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(arcBgIV.snp.top)
            make.centerX.equalTo(arcBgIV.snp.centerX)
            make.top.equalTo(0)
        }

        let icon = UIImageView()
        self.icon = icon
        self.addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.bottom.equalTo(arcBgIV.snp.top).offset(8)
            make.centerX.equalTo(arcBgIV.snp.centerX)
            make.top.equalTo(0)
        }
        icon.isHidden = true
    }
}
