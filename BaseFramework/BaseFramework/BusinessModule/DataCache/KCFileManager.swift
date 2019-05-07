/*******************************************************************************
 # File        : KCFileManager.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/7/6
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit

class KCFileManager: NSObject {
    /// 单例
    static let sharedInstance: KCFileManager = KCFileManager()

    override init() {
        KCLog.info("沙盒路径:\(NSHomeDirectory())")
    }

    ///
    /// 获取Documents路径
    ///
    /// - Returns: 返回路径
    public func getDocumentsPath() -> String {

        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)

        if let path = paths.first {
            return path
        } else {
            KCLog.warn("获取沙盒路径失败")

            return ""
        }
    }

    /// 根据传入的文件夹名创建文件夹📂
    ///
    /// - Parameter directoryName: 传入的文件夹名
    public func createDirectory(_ directoryName: String) -> Bool {

        /// 获取路径
        let path = KCFileManager.sharedInstance.getDocumentsPath()

        /// 创建文件管理者
        let fileManger = FileManager.default

        /// 创建文件夹
        let directoryPath = path + ("/\(directoryName)")

        var createResult: Bool = false

        if !fileManger.fileExists(atPath: directoryPath) { /// 先判断是否存在  不存在再创建
            do {
                try fileManger.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
                KCLog.info("文件夹创建成功")
                createResult = true
            } catch let error {
                KCLog.warn(error.localizedDescription)
                KCLog.info("文件夹创建失败")
            }
        } else {
            createResult = true
        }

        return createResult

    }

    /// 根据传入的文件名创建文件
    ///
    /// - Parameter fileName: 传入的文件名
    /// - Returns: 返回文件名
    public func createFile(_ fileName: String) -> (String) {

        /// 获取路径
        let path = KCFileManager.sharedInstance.getDocumentsPath()

        /// 创建文件管理者
        let fileManger = FileManager.default

        /// 创建文件
        let filePath = path + ("/\(fileName)")

        if !fileManger.fileExists(atPath: filePath) { /// 先判断是否存在  不存在再创建

            let isSuccess = fileManger.createFile(atPath: filePath, contents: nil, attributes: nil)

            if isSuccess {
                KCLog.info("文件创建成功")
            } else {
                KCLog.warn("文件创建失败")
            }
        }

        return filePath
    }

    /// 写入文件
    ///
    /// - Parameters:
    ///   - data: 要写入的数据
    ///   - filePath: 要写入的文件路径
    /// - Returns: 是否写入成功
    public func writeFile(_ data: AnyObject, _ filePath: String) -> Bool {

        return  data.write(toFile: filePath, atomically: true)
    }

    /// 读取文件内容
    ///
    /// - Parameter filePath: 要读取的文件路径
    /// - Returns: 返回文件中数据
    public func readFileContent(_ filePath: String) -> AnyObject {

        /// 因为我的项目是存的数组 所以我返回的数组
        return NSArray(contentsOfFile: filePath) ?? []
    }

    /// 获取文件的大小
    ///
    /// - Returns: 文件大小
    public func getFileSize(_ fileName: String) -> Double {

        let fileManger = FileManager.default

        guard fileManger.fileExists(atPath: fileName) else {
            return 0
        }

        if let attr = try? fileManger.attributesOfItem(atPath: fileName) {
            let fileSize = Double((attr as NSDictionary).fileSize())
            return fileSize / 1048576
        }
        return 0
    }

}
