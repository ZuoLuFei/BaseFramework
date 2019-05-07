/*******************************************************************************
 # File        : KCTitleImageButton.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/8/28
 # Corporation : ****
 # Description : 标题在前，图片在后button
 ******************************************************************************/

import UIKit
import RxCocoa

class KCTitleImageButton: UIView {
    weak var container: UIView!
    weak var titleLab: UILabel!
    weak var imgIV: UIImageView!

    /**
     * 点击事件
     */
    var clickBlock: (() -> Void)?

    /// 是否被选中
    var isSelected = BehaviorRelay<Bool>(value: false)

    /**
     * 标题、图片横向排列方式
     */
    var alignment: NSTextAlignment? {
        didSet {
            guard let alignment = alignment else { return }
            switch alignment {
            case .left:
                container.snp.makeConstraints { (make) in
                    make.leading.equalTo(0)
                }
            case .right:
                container.snp.makeConstraints { (make) in
                    make.trailing.equalTo(0)
                }
            case .center:
                container.snp.makeConstraints { (make) in
                    make.centerX.equalTo(self.snp.centerX)
                }
            default:
                break
            }
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
        let container = UIView()
        self.container = container
        self.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
        }

        let titleLab = UILabel()
        self.titleLab = titleLab
        container.addSubview(titleLab)
        titleLab.snp.makeConstraints { (make) in
            make.top.bottom.leading.equalTo(0)
        }
        titleLab.font = UIFont.pingFangWith(size: 12)

        let imgIV = UIImageView()
        self.imgIV = imgIV
        container.addSubview(imgIV)
        imgIV.snp.makeConstraints { (make) in
            make.leading.equalTo(titleLab.snp.trailing).offset(5)
            make.centerY.equalTo(titleLab)
            make.trailing.equalTo(0)
        }

        let tap = UITapGestureRecognizer(target: self, action: #selector(_handleTap))
        self.addGestureRecognizer(tap)
    }

    @objc private func _handleTap() {
        clickBlock?()
    }
}

class KCSelfGrowthTitleImageButton: KCTitleImageButton {
    override init() {
        super.init()
        _initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func _initUI() {
        container.snp.remakeConstraints({ (make) in
            make.edges.equalTo(0)
        })
    }
}
