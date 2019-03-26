//
//  AsunAPI.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//

import Moya
import HandyJSON
import MBProgressHUD
import SwiftyJSON

// 请求Loading
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = rootPresentedVC else { return }
    switch type {
    case .began:
        MBProgressHUD.hide(for: vc.view, animated: false)
        MBProgressHUD.showAdded(to: vc.view, animated: true)
    case .ended:
        MBProgressHUD.hide(for: vc.view, animated: true)
    }
}


// 超时时间
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<AsunAPI>.RequestResultClosure) -> Void in

    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}



enum AsunAPI {

    case parentCategoryNumberOfBooks

}

extension AsunAPI: TargetType {
    var task: Task {
        var parmeters = ["time": Int32(Date().timeIntervalSince1970),
                         "device_id": UIDevice.current.identifierForVendor!.uuidString,
                         "model": UIDevice.current.modelName,
                         "version": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
        switch self {
        case .parentCategoryNumberOfBooks: break

        default:
            break
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    var baseURL: URL {
        return URL(string: "http://novel.juhe.im/")!
    }

    var path: String {
        switch self {
        case .parentCategoryNumberOfBooks:
            return "categories"
        default:
            break
        }
    }

    var method: Moya.Method { return .get }
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

struct Network {
    static let ApiProvider = MoyaProvider<AsunAPI>(requestClosure: timeoutClosure)
    static let ApiLoadingProvider = MoyaProvider<AsunAPI>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

    static func request<T: HandyJSON>(_ isLodaing:Bool,
        _ target: AsunAPI,
        _ type: T.Type,
        success successCallback: @escaping (T?) -> Void,
        error errorCallback: @escaping (Int) -> Void,
        failure failureCallback: @escaping (MoyaError) -> Void
        ) {
        if isLodaing {
            ApiLoadingProvider.request(target) { result in
                switch result {
                case let .success(response):
                    do {
                        //如果数据返回成功则直接将结果转为JSON
                        try response.filterSuccessfulStatusCodes()
                        let json = try response.mapString()
                        guard let model = JSONDeserializer<T>.deserializeFrom(json: json) else {
                            return
                        }
                        successCallback(model)
                    }
                    catch let error {
                        //如果数据获取失败，则返回错误状态码
                        errorCallback((error as! MoyaError).response!.statusCode)
                    }
                case let .failure(error):
                    failureCallback(error)
                }
            }
        } else {
            ApiProvider.request(target) { result in
                switch result {
                case let .success(response):
                    do {
                        //如果数据返回成功则直接将结果转为JSON
                        try response.filterSuccessfulStatusCodes()
                        let json = try response.mapString()
                        guard let model = JSONDeserializer<T>.deserializeFrom(json: json) else {
                            return
                        }
                        successCallback(model)
                    }
                    catch let error {
                        //如果数据获取失败，则返回错误状态码
                        errorCallback((error as! MoyaError).response!.statusCode)
                    }
                case let .failure(error):
                    failureCallback(error)
                }
            }
        }
    }
}
