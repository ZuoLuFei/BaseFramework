/*******************************************************************************
 # File        : Thread+kcExtension.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/10
 # Corporation : ****
 # Description :
 ******************************************************************************/

import Foundation

extension Thread {

    /// 延时方法
    ///
    /// - Parameters:
    ///   - time: 时间
    ///   - task: 需要延时执行的任务
    /// - Returns: 延时任务
    static func delay(_ time: TimeInterval, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
            execute()
        }
    }

    /// 切回主线程执行事件
    ///
    /// - Parameter event: 执行事件
    static func changeToMainThread(_ event: @escaping (() -> Void)) {

        if Thread.current.isMainThread {
            event()
        } else {
            DispatchQueue.main.async {
                event()
            }
        }
    }
}
