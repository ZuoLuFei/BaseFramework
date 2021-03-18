/*******************************************************************************
 # File        : KCPollManager.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/9/6
 # Corporation : ****
 # Description : 轮询管理者
 ******************************************************************************/

import UIKit

class KCPollManager: NSObject {

    static let share = KCPollManager()

    private lazy var tasks: [String: Task] = [:]
    private var timer: Timer?
    private var tick: Int = 0  // 时间计数，目前计数到180，重新从0开始计数

    func register(key: String, interval: Time, action: (() -> Void)?) {
        guard let validAction = action else { return }

        // 先执行一次任务
        validAction()

        KCLog.info("开启轮询: \(key)")

        if timer == nil {
            _initTimer()

        }

        tasks[key] = Task(interval: interval, action: validAction)
    }

    func remove(key: String) {
        guard tasks[key] != nil else { return }

        KCLog.info("关闭轮询: \(key)")

        tasks.removeValue(forKey: key)

        if tasks.count < 1 {
            timer?.invalidate()
            timer = nil
        }
    }

    func update(key: String, frequency: Time) {

    }

    private func _initTimer() {
        let timer = Timer(timeInterval: 1.0,
                          target: self,
                          selector: #selector(_handleTimeTick),
                          userInfo: nil,
                          repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
        self.timer = timer
        timer.fire()
    }

    @objc private func _handleTimeTick() {
        tick = (tick + 1) % 181

        for task in tasks.values where tick % task.interval.rawValue == 0 {
            DispatchQueue.main.async {

                task.action()
            }
        }
    }
}

extension KCPollManager {
    struct Task {
        var interval: Time
        var action: (() -> Void)
    }

    enum Time: Int {
        case normal = 10
        case high = 3
        case low = 180
    }
}
