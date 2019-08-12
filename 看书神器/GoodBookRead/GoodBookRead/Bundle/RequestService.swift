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


    static func requestLogin(username: String , password: String) -> Observable<LoginModel> {
        return Network.request(false, target: AsunAPI.login(action:actionEnum.login.rawValue , account: username, passWord: password, cookie: "43200", submit: "提交"), type: LoginModel.self)
    }

}
