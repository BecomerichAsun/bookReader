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
        urlRequest.httpShouldHandleCookies = false
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

    case login(action: String ,account: String ,passWord: String , cookie: String, submit: String)

    case localBooks
}

extension AsunAPI: TargetType {
    var task: Task {
        var parmeters = [String:Any]()
        switch self {
        case .parentCategoryNumberOfBooks: break
        case .classificationDetails(_,_,_,_):break
        case .bookInfo(_):break
        case .login(let action,let account,let passWord,let cookie,let submit):
            parmeters["action"] = action
            parmeters["username"] = account
            parmeters["password"] = passWord
            parmeters["usecookie"] = cookie
            parmeters["submit"] = submit
        case .localBooks: break
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    var baseURL: URL {
        let str = "https://shuapi.jiaston.com/"
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
        case .login(_,_,_,_,_):
            return URL(string: str)!
        case .localBooks:
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
        case .login(_,_,_,_,_):
            return "Login.aspx"
        case .localBooks:
            return "Bookshelf.aspx"
        }
    }

    var method: Moya.Method {
        switch self {
        case .login(_,_,_,_,_):
            return .post
        default:
            return .get
        }
    }
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? {
        switch self {
        case .localBooks:
            return [
                "content-type": "application/x-www-form-urlencoded","cookie":"m_uid=d145dc4b-6059-475c-939e-b0ac1b061cc5; member_username=\(UserDefaults.standard.string(forKey: UserDefaultsKey.username.rawValue) ?? "");"]
        default:
            return [
                "content-type": "application/x-www-form-urlencoded"]
        }
    }
}

struct Network {
    static let ApiProvider = MoyaProvider<AsunAPI>(requestClosure: timeoutClosure)
    static let ApiLoadingProvider = MoyaProvider<AsunAPI>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])
    static func request<T: HandyJSON>(_ isLodaing:Bool? = false ,
         target: AsunAPI,
         type: T.Type ,_ isCancel:Bool? = true) -> Observable<T> {
        if isLodaing! {
            return ApiLoadingProvider.rx.asunRequest(target, type: type, isCancel: isCancel!)
        } else {
            return ApiProvider.rx.asunRequest(target, type: type, isCancel: isCancel!)
        }
    }
}
