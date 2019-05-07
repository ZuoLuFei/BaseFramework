/*******************************************************************************
 # File        : KCPageControl.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/8/27
 # Corporation : ****
 # Description : 模仿系统的PageControl, 方便自定义UI
 ******************************************************************************/

import UIKit

class KCPageControl: UIView {
    private lazy var items: [UIView] = []

    var currentIndex: Int = 0 {
        didSet {
            _updateUI()
        }
    }

    var numberOfPages: Int = 0 {
        didSet {
            _resetUI()
        }
    }

    private func _resetUI() {
        for subView in self.subviews {
            subView.removeFromSuperview()
        }

        items = []

        for i in 0..<numberOfPages {
            let item = UIView()
            self.addSubview(item)
            item.snp.makeConstraints { (make) in
                make.top.equalTo(0)
                make.width.height.equalTo(4)
            }

            if i == 0 {
                item.snp.makeConstraints { (make) in
                    make.leading.equalTo(0)
                }
            } else {
                item.snp.makeConstraints { (make) in
                    make.leading.equalTo(items[i - 1].snp.trailing).offset(4)
                }
            }

            if i == numberOfPages - 1 {
                item.snp.makeConstraints { (make) in
                    make.trailing.equalTo(0)
                }
            }

            items.append(item)
            item.backgroundColor = UIColor.black
            item.layer.cornerRadius = 2
        }
    }

    private func _updateUI() {
        for (i, item) in items.enumerated() {
            if i == currentIndex {
                item.backgroundColor = UIColor.black
                item.snp.updateConstraints { (make) in
                    make.width.equalTo(8)
                }
            } else {
                item.backgroundColor = UIColor.red
                item.snp.updateConstraints { (make) in
                    make.width.equalTo(4)
                }
            }
        }
    }
}
