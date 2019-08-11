//
//  AsunAPI.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//

import Moya
import HandyJSON
import RxSwift
import RxCocoa

// 请求Loading
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = rootPresentedVC else { return }
    switch type {
    case .began:
        LoadingAnimationView.show()
    case .ended:
        LoadingAnimationView.dismiss()
    }
}

// 超时时间
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<AsunAPI>.RequestResultClosure) -> Void in
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 10
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}


enum AsunAPI {
    //父分类
    case parentCategoryNumberOfBooks
    //分类详情
    case classificationDetails(gender:String,major:String,start:Int,limit:Int)
    // 书籍详情
    case bookInfo(id:String)
}

extension AsunAPI: TargetType {
    var task: Task {
        var parmeters = ["time": Int32(Date().timeIntervalSince1970),
                         "device_id": UIDevice.current.identifierForVendor!.uuidString,
                         "model": UIDevice.current.modelName,
                         "version": Bundle.main.infoDictionary!["CFBundleShortVersionString"]!]
        switch self {
        case .parentCategoryNumberOfBooks: break
        case .classificationDetails(_,_,_,_):break
        case .bookInfo(_):break
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    var baseURL: URL {
        switch self {
        case .classificationDetails(let gender,let major,let start,let limit):
            let str: String = "http://novel.juhe.im/category-info?"
            let queryItem1 = NSURLQueryItem(name: "gender", value: gender)
            let queryItem5 = NSURLQueryItem(name: "type", value: "hot")
            let queryItem2 = NSURLQueryItem(name: "major", value: major)
            let queryItem3 = NSURLQueryItem(name: "start", value: "\(start)")
            let queryItem4 = NSURLQueryItem(name: "limit", value: "\(limit)")
            let urlCom = NSURLComponents(string: str)
            urlCom?.queryItems = [queryItem1, queryItem5,queryItem2,queryItem3,queryItem4] as [URLQueryItem]
            return (urlCom?.url!)!
        case .bookInfo(let id):
            let str:String = "http://novel.juhe.im/book-info/\(id)"
            return URL(string: str)!
        default:
             return URL(string: "http://novel.juhe.im")!
        }
    }

    var path: String {
        switch self {
        case .parentCategoryNumberOfBooks:
            return "/categories"
        case .classificationDetails( _, _, _, _):
            return ""
        case .bookInfo(_):
            return ""
        }
    }

    var method: Moya.Method { return .get }
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

struct Network {
    static let ApiProvider = MoyaProvider<AsunAPI>(requestClosure: timeoutClosure)
    static let ApiLoadingProvider = MoyaProvider<AsunAPI>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

    static func request<T: HandyJSON>(_ isLodaing:Bool? = false ,
         target: AsunAPI,
         type: T.Type ) -> Observable<T> {

        if isLodaing! {
            return ApiLoadingProvider.rx.asunRequest(target, type: type)
        } else {
            return ApiProvider.rx.asunRequest(target, type: type)
        }
    }
}
