//
//  ExtensionRequest.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/5.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import HandyJSON
struct ExtensionNetworkService {
    /// 首页数据
    ///
    /// - Returns: 返回模型序列
    static func requestData() -> Observable<ParentExtensionModule> {
        return Network.request(true, target: AsunAPI.parentCategoryNumberOfBooks, type: ParentExtensionModule.self).asObservable()
    }
    
    static func requestHotBookList(params: BookeDetailParams,start: Int) -> Observable<BookDetailModule> {
        return Network.request(true, target: AsunAPI.classificationDetails(gender: params.gender, major: params.major, start: start, limit: 20), type: BookDetailModule.self).asObservable()
    }
}
