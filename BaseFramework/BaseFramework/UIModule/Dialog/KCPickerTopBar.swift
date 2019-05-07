/*******************************************************************************
 # File        : KCPickerTopBar.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/10/22
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

class KCPickerTopBar: UIView {

    weak var cancelBtn: UIButton!
    weak var confirmBtn: UIButton!

    init() {
        super.init(frame: CGRect.zero)
        _initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        KCLog.info("释放了\(KCPickerTopBar.self)")
    }

    private func _initUI() {
        let cancelBtn = UIButton()
        self.cancelBtn = cancelBtn
        self.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { (make) in
            make.leading.equalTo(24)
            make.top.bottom.equalTo(0)
            make.width.equalTo(80)
        }
        cancelBtn.contentHorizontalAlignment = .left
        cancelBtn.titleLabel?.font = UIFont.pingFangMediumWith(size: 16)
        cancelBtn.setTitleColor(.black, for: .normal)
        cancelBtn.setTitle("取消", for: .normal)

        let confirmBtn = UIButton()
        self.confirmBtn = confirmBtn
        self.addSubview(confirmBtn)
        confirmBtn.snp.makeConstraints { (make) in
            make.trailing.equalTo(-24)
            make.top.bottom.equalTo(0)
            make.width.equalTo(80)
        }
        confirmBtn.contentHorizontalAlignment = .right
        confirmBtn.titleLabel?.font = UIFont.pingFangMediumWith(size: 16)
        cancelBtn.setTitleColor(.black, for: .normal)
        cancelBtn.setTitle("确认", for: .normal)
    }
}
