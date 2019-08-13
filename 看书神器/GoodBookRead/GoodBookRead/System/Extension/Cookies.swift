//
//  Cookies.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/13.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation

struct Cookies {
    static func addCookie() {

        if !(UserDefaults.standard.string(forKey: UserDefaultsKey.username.rawValue)?.count ?? 0 > 0) {
             return
        }

        var propsUsername = Dictionary<HTTPCookiePropertyKey, Any>()
        var propsUid = Dictionary<HTTPCookiePropertyKey, Any>()
        var propsSessionId = Dictionary<HTTPCookiePropertyKey, Any>()
        propsUsername[HTTPCookiePropertyKey.name] = "member_username"
        propsUsername[HTTPCookiePropertyKey.value] = UserDefaults.standard.string(forKey: UserDefaultsKey.username.rawValue) ?? ""
        propsUsername[HTTPCookiePropertyKey.path] = "/"
        propsUsername[HTTPCookiePropertyKey.domain] = ".jiaston.com"
        propsUsername[HTTPCookiePropertyKey.secure] = false

        propsUid[HTTPCookiePropertyKey.name] = "m_uid"
        propsUid[HTTPCookiePropertyKey.value] = "d145dc4b-6059-475c-939e-b0ac1b061cc5"
        propsUid[HTTPCookiePropertyKey.path] = "/"
        propsUid[HTTPCookiePropertyKey.domain] = ".jiaston.com"
        propsUid[HTTPCookiePropertyKey.secure] = false

        propsSessionId[HTTPCookiePropertyKey.name] = "ASP.NET_SessionId"
        propsSessionId[HTTPCookiePropertyKey.value] = "cowzeqrnvfvjuzewkpmziqvg"
        propsSessionId[HTTPCookiePropertyKey.path] = "/"
        propsSessionId[HTTPCookiePropertyKey.domain] = ".jiaston.com"
        propsSessionId[HTTPCookiePropertyKey.secure] = false

        let cookieUser = HTTPCookie(properties: propsUsername)
        let cookieUid = HTTPCookie(properties: propsUid)
        let cookieSessionID = HTTPCookie(properties: propsSessionId)
        let cstorage = HTTPCookieStorage.shared
        cstorage.setCookie(cookieUser!)
        cstorage.setCookie(cookieUid!)
        cstorage.setCookie(cookieSessionID!)
    }
}
