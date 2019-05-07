/*******************************************************************************
 # File        : KCDataModel.swift
 # Project     : &&&&
 # Author      : &&&&
 # Created     : 2018/9/5
 # Corporation : ****
 # Description :
 ******************************************************************************/

import UIKit
import Moya
import ObjectMapper

class KCDataModel: NSObject {
    var request: Cancellable?

    func cancel() {
        request?.cancel()
    }
}
