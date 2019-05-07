/*******************************************************************************
 # File        : KCLog.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/9/3
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit
import SwiftyBeaver

class KCLog: NSObject {
    private static let share: SwiftyBeaver.Type = {
        let log = SwiftyBeaver.self

        let console = ConsoleDestination()
        console.format = "$DHH:mm:ss $C $M"

        #if DEBUG
            console.minLevel = .info
        #else
            console.minLevel = .error
        #endif

        log.addDestination(console)
        return log
    }()

    /**
     * 打印普通log日志
     */
    static func info(_ message: Any) {
        self.share.info(message)
    }

    /**
     * 打印错误警告log日志
     */
    static func warn(_ message: Any) {
        self.share.warning(message)
    }
}
