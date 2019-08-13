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


        var propsUid = Dictionary<HTTPCookiePropertyKey, Any>()
//        var propsSessionId = Dictionary<HTTPCookiePropertyKey, Any>()
//        var propsMUid = Dictionary<HTTPCookiePropertyKey, Any>()

        propsUid[HTTPCookiePropertyKey.name] = "m_uid"
        propsUid[HTTPCookiePropertyKey.value] = "d145dc4b-6059-475c-939e-b0ac1b061cc5"
        propsUid[HTTPCookiePropertyKey.path] = "/"
        propsUid[HTTPCookiePropertyKey.domain] = ".jiaston.com"
        propsUid[HTTPCookiePropertyKey.secure] = false

//        propsSessionId[HTTPCookiePropertyKey.name] = "ASP.NET_SessionId"
//        propsSessionId[HTTPCookiePropertyKey.value] = "30pw0z3d4o0o0up2pm54ginl"
//        propsSessionId[HTTPCookiePropertyKey.path] = "/"
//        propsSessionId[HTTPCookiePropertyKey.domain] = ".jiaston.com"
//        propsSessionId[HTTPCookiePropertyKey.secure] = false


//        propsMUid[HTTPCookiePropertyKey.name] = "__cfduid"
//        propsMUid[HTTPCookiePropertyKey.value] = "d70f0ecdc20471e8ff74ebb05a457842b1565665567"
//        propsMUid[HTTPCookiePropertyKey.path] = "/"
//        propsMUid[HTTPCookiePropertyKey.domain] = "jiaston.com"
//        propsMUid[HTTPCookiePropertyKey.secure] = false

        let cookieUid = HTTPCookie(properties: propsUid)
//        let cookieSessionID = HTTPCookie(properties: propsSessionId)
//        let cookieMUid = HTTPCookie(properties: propsMUid)
        let cstorage = HTTPCookieStorage.shared

        cstorage.setCookie(cookieUid!)
//        cstorage.setCookie(cookieSessionID!)
//        cstorage.setCookie(cookieMUid!)
    }
    
    static func addUsernameCookie(cookie: String) {
        var propsUsername = Dictionary<HTTPCookiePropertyKey, Any>()
        propsUsername[HTTPCookiePropertyKey.name] = "member_username"
        propsUsername[HTTPCookiePropertyKey.value] = cookie
        propsUsername[HTTPCookiePropertyKey.path] = "/"
        propsUsername[HTTPCookiePropertyKey.domain] = "jiaston.com"
        propsUsername[HTTPCookiePropertyKey.secure] = false
        let cookieUser = HTTPCookie(properties: propsUsername)
        let cstorage = HTTPCookieStorage.shared
        cstorage.setCookie(cookieUser!)
    }

    static func removeAllCookies() {
        let cstorage = HTTPCookieStorage.shared
        if let cookies = cstorage.cookies {
            for cookie in cookies {
                cstorage.deleteCookie(cookie)
            }
        }
    }
}
