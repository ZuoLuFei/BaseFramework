/*******************************************************************************
 # File        : KCRealmEntity.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/9/14
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit
import RealmSwift
import Realm

class KCRealmEntity: Object, Mappable {

    required override init() {
        super.init()
    }

    required init?(map: Map) {
        super.init()
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        fatalError("init(realm:schema:) has not been implemented")
    }

    required init(value: Any, schema: RLMSchema) {
        fatalError("init(value:schema:) has not been implemented")
    }

    func mapping(map: Map) {
    }

}
