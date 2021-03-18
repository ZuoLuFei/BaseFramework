/*******************************************************************************
 # File        : KCNetWorkCenter.swift
 # Project     : &&&&
 # Author      : ####
 # Created     : 2018/7/16
 # Corporation : ****
 # Description : 网络配置中心
 ******************************************************************************/

import UIKit
import Moya
import Result

// 请求成功的回调
typealias SuccessBlock = (_ data: Any?) -> Void
// 请求失败的回调
typealias FailureBlock = (_ error: KCError) -> Void

// 网络返回数据过滤层
protocol KCResponseFilterProtocol {
    static func filter(_ result: Moya.Response, success: SuccessBlock?, failure: FailureBlock?)

    static func rxFilter(_ result: Moya.Response, data: inout Any?, error: inout KCError?)
}

extension KCResponseFilterProtocol {
    static func filter(_ result: Moya.Response, success: SuccessBlock?, failure: FailureBlock?) {

    }

    static func rxFilter(_ result: Moya.Response, data: inout Any?, error: inout KCError?) {

    }
}

class KCNetWorkCenter<T: KCResponseFilterProtocol> {
    private let bag = DisposeBag()
    private let provider: MoyaProvider<KCNetworkTargetType> = {
        return MoyaProvider<KCNetworkTargetType>(
            endpointClosure: KCMoyaPluginCenter.myEndpointClosure,
            requestClosure: KCMoyaPluginCenter.myRequestClosure,
            plugins: [KCMoyaPluginCenter.shareMoyaPluginCenter.myNetWorkFilterPlugin]
        )
    }()

    deinit {
        //print("deinit")
    }

    @discardableResult
    func request(target: KCNetworkTargetType,
                 success: SuccessBlock?,
                 failure: FailureBlock?) -> Cancellable {
        return provider.request(target) { (result) in
            switch result {
            case let .success(response):
                switch target {
                case let .get(baseUrl: _, url: _, parameters: _, startShow: _, endShow: _, logger: showLog):
                    KCNetWorkCenter._checkLog(target, response, nil, showLog)
                case let .post(baseUrl: _, url: _, parameters: _, parameType: _, startShow: _, endShow: _, logger: showLog):
                    KCNetWorkCenter._checkLog(target, response, nil, showLog)
                }

                // 数据过滤处理
                T.filter(response, success: success, failure: failure)
            case let .failure(error):
                KCNetWorkCenter._checkLog(target, nil, error, true)
                failure?(KCError(code: "11", msg: "未知错误"))
            }
        }
    }

    func rxRequest(target: KCNetworkTargetType) -> Observable<Any?> {
        return Observable<Any?>.create { (observer) -> Disposable in
            let disposeableToken = self.provider.rx.request(target).subscribe(onSuccess: { (result) in
                var data: Any?
                var error: KCError?
                T.rxFilter(result, data: &data, error: &error)
                if error != nil {
                    observer.onError(error!)
                } else {
                    observer.onNext(data)
                    observer.onCompleted()
                }
            }, onError: { (error) in
                observer.onError(error)
            })

            return Disposables.create {
                disposeableToken.dispose()
            }
        }
    }

    func cancel(urlStr: String) {
        guard let url = URL(string: urlStr) else { return }
        provider.session.session.dataTask(with: url).cancel()
//        provider.manager.session.dataTask(with: url).cancel()
    }

    func cancelAll() {
        provider.session.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        }
//        provider.manager.session.getTasksWithCompletionHandler { dataTasks, uploadTasks, downloadTasks in
//            dataTasks.forEach { $0.cancel() }
//            uploadTasks.forEach { $0.cancel() }
//            downloadTasks.forEach { $0.cancel() }
//        }
    }

    func test(target: KCNetworkTargetType) -> Observable<KCResponse?> { //  -> Single<Response>

//        return Observable<KCResponse?>.create { [weak self] (observer) -> Disposable in
//            return self?.provider.rx.request(target).subscribe(onSuccess: { (result) in
//                let value = result.data
//                let data = Mapper<KCResponse>().map(JSONObject: value)
//                observer.onNext(data)
//                observer.onCompleted()
//            }, onError: { (error) in
//                observer.onError(error)
//            }) ?? Disposables.create()
//        }

        return Observable.create { observer in
            let disposeableToken = self.provider.rx.request(target).subscribe(onSuccess: { (response) in
                let value = response.data
                let data = Mapper<KCResponse>().map(JSONObject: value)
                observer.onNext(data)
                observer.onCompleted()
            }, onError: { (error) in
                observer.onError(error)
            })
            return Disposables.create {
                disposeableToken.dispose()
            }
//                switch result {
//                case let .success(response):
//                    observer.onNext(response)
//                    observer.onCompleted()
//                case let .failure(error):
//                    observer.onError(error)
//                }
//            }

        }
//        return provider
//            .rx
//            .request(target).mapJSON().map

//            .subscribe({ (event) in
//                switch event {
//                case .success(let response):
//                    print(response)
//                // do something with the data
//                case .error(let error):
//                    print(error)
//                    // handle the error
//                }
//            })

    }
}

// MARK: - private
extension KCNetWorkCenter {
    static private func _checkLog(_ target: KCNetworkTargetType, _ response: Response?, _ error: MoyaError?, _ showLog: Bool) {
        guard KCGlobalSwitch.moyaLoggerResponsePlugin && showLog else { return }

        KCLog.info("\n***************Moya.Response Start Log***************")

        let url = target.baseURL.appendingPathComponent(target.path).absoluteString

        if let response = response {
            KCLog.info("\n Moya.Response:\n url -- \(url)\n description -- \(response.description)\n data -- \(JSON(response.data))")
        } else if let error = error {
            KCLog.info("\n Moya.Response:\n url -- \(url)\n error -- \(error)\n ")
        }

        KCLog.info("***************Moya.Response End Log***************")
    }
}
