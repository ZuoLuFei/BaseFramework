/*******************************************************************************
 # File        : KCSendCountDownButton.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/10/10
 # Corporation : ****
 # Description : 发送倒计时按钮
 ******************************************************************************/

import UIKit

enum SendCountDownButtonState: Int {
    case normal     // 普通状态
    case sending    // 发送状态
    case countDown  // 倒计时状态
}

class KCSendCountDownButton: UIButton {

    private var timer: Timer?
    private var count: Int = 0

    var btnState: SendCountDownButtonState = .normal {
        didSet {
            _updateUI()
        }
    }

    init() {
        super.init(frame: CGRect.zero)
        _initUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        KCLog.info("释放了\(KCSendCountDownButton.self)")
    }

    private func _initUI() {
        titleLabel?.font = UIFont.pingFangWith(size: 16)
        setTitleColor(UIColor.black, for: .normal)
        backgroundColor = UIColor.blue
        setTitle("发送", for: .normal)
    }

    private func _updateUI() {
        switch btnState {
        case .normal:
            setTitleColor(UIColor.black, for: .normal)
            isEnabled = true
            setTitle("发送", for: .normal)
        case .sending:
            isEnabled = false
        case .countDown:
            setTitleColor(UIColor.gray, for: .normal)
            isEnabled = false
            count = 60
            _initTimer()
        }
    }

    private func _initTimer() {
        let timer = Timer(timeInterval: 1.0,
                          target: self,
                          selector: #selector(_handleTimeTick),
                          userInfo: nil,
                          repeats: true)
        RunLoop.current.add(timer, forMode: .commonModes)
        self.timer = timer
        timer.fire()
    }

    @objc private func _handleTimeTick() {
        count -= 1

        if count < 1 {
            btnState = .normal
        } else {
            setTitle("\(count)", for: .normal)
        }
    }
}
