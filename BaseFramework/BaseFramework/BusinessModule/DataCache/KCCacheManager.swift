/*******************************************************************************
 # File        : KCCacheManager.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/13
 # Corporation : ****
 # Description : 全局统一缓存工具，根据用户创建数据库，非登录用户数据全部存储于公共数据库
 ******************************************************************************/

import UIKit
import RealmSwift
import Realm

class KCKeyValueModel: KCRealmEntity {
    @objc dynamic var key = ""
    @objc dynamic var value = ""

    override static func primaryKey() -> String? {
        return "key"
    }

    override func mapping(map: Map) {
        key   <- map["key"]
        value <- map["value"]
    }
}

// MARK: - Array
class KCCacheManager: NSObject {
    static let share = KCCacheManager()

    /// 缓存字典
    private var _cacheDict: [String: Any?] = [:]

    /// 存储数组
    func save<T: KCRealmEntity>(items: [T]) {
        guard let valueJsons = items.toJSONString() else { return }
        DispatchQueue.global().async {
            guard let items = Mapper<T>().mapArray(JSONString: valueJsons) else { return }

            let realm: Realm? = try? Realm()
            try? realm?.write {
                realm?.add(items, update: .modified)
            }
        }
    }

    /// 获取数据
    func obtion<T: KCRealmEntity>(_ type: T.Type) -> [T]? {
        let realm = try? Realm()
        let results = realm?.objects(type)

        return results?.map({ $0 })
    }
}

// MARK: - key value
extension KCCacheManager {
    func save(key: String, value: String) {
        DispatchQueue.global().async {
            guard let model = KCKeyValueModel(JSON: [:]) else { return }
            model.key = key
            model.value = value
            let realm = try? Realm()
            try? realm?.write {
                realm?.add(model, update: .modified)
            }
        }
    }

    func obtain(key: String) -> String? {
        let realm = try? Realm()
        return realm?.object(ofType: KCKeyValueModel.self, forPrimaryKey: key)?.value
    }
}
