
//
//  Model.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/12.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import HandyJSON

struct LoginModel: HandyJSON {
    var status: Int = 0
    var info: String?
    var data: loginDataModel?
}

struct loginDataModel: HandyJSON {
    var message: String?
    var userInfo: UserInfoModel?
    var status: Int = 0
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.userInfo <-- "UserInfo"
        mapper <<<
            self.message <-- "Message"
        mapper <<<
            self.status <-- "Status"
    }
}

struct UserInfoModel: HandyJSON {
    var noAdTitle: String?
    var email: String?
    var userName: String?
    var isNoAd: Bool = false
    var vipLevel: Int = 0

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.userName <-- "UserName"
        mapper <<<
            self.email <-- "Email"
        mapper <<<
            self.noAdTitle <-- "NoAdTitle"
        mapper <<<
            self.isNoAd <-- "IsNoAd"
        mapper <<<
            self.vipLevel <-- "VipLevel"
    }
}

