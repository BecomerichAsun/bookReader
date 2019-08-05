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

class ExtensionRequest {
    @discardableResult
    func requestData() -> Driver<ParentViewModule> {
        var newValue:Driver<ParentViewModule> = Driver.from(optional: nil)
        Network.request(true, AsunAPI.parentCategoryNumberOfBooks, ParentExtensionModule.self, success: {(value) in
            guard value != nil else { return }
            newValue = Driver.from(optional: ParentViewModule(module: value!))
        }, error: { (_) in
           
        }) { (_) in
//            self.isRefreshed.accept(.networkError(message: ResultTips.network.rawValue))
        }
        return newValue.delay(0.1).asDriver(onErrorDriveWith: Driver.empty())
    }
}
