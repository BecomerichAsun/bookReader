//
//  RequestService.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/12.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import HandyJSON

fileprivate enum actionEnum: String {
    case login = "login"
}



struct RequestService {
    // 图片下载地址
    static let donwondURl = "https://imgapi.jiaston.com/BookFiles/BookImages/"

    // 登录
    static func requestLogin(username: String , password: String) -> Observable<LoginModel> {
        return Network.request(false, target: AsunAPI.login(action:actionEnum.login.rawValue , account: username, passWord: password, cookie: "43200"), type: LoginModel.self)
    }
    // 获取当前账号收藏书籍
    static func requestLocalBook(isLoading: Bool) -> Observable<BookCaseModel> {
        return Network.request(isLoading, target: AsunAPI.localBooks, type: BookCaseModel.self)
    }
}
