/*******************************************************************************
 # File        : KCActionButton.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/9/17
 # Corporation : ****
 # Description : 通用的确认按钮
 ******************************************************************************/

import UIKit

class KCActionButton: UIButton {

    var isValid: Bool = false {
        didSet {
            if isValid {
                backgroundColor = UIColor.gray
                setTitleColor(UIColor.black.withAlphaComponent(0.5), for: .normal)
            } else {
                backgroundColor = UIColor.blue
                setTitleColor(UIColor.black, for: .normal)
            }

            isEnabled = isValid
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        _initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _initUI() {
        titleLabel?.font = UIFont.pingFangMediumWith(size: 15)
        layer.cornerRadius = 4
//        kcBackgroundColor = KCTheme.Color.tipWord
//        kc_setTitleColorPicker(KCTheme.Color.contentWord, forState: .normal)
        isEnabled = false
    }
}
