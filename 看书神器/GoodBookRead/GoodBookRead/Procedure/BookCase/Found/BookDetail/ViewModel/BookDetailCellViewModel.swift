//
//  BookDetailCellViewModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/11.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct BookDetailCellViewModel {
    let bag = DisposeBag()
    let authorName: BehaviorRelay<String>
    var bookName: BehaviorRelay<String>
    var isFinished: BehaviorRelay<String>
    var bookTags: BehaviorRelay<[String]>
}

extension BookDetailCellViewModel {
    init(model: BookIdDetailModule) {
        authorName = BehaviorRelay(value: model.author ?? "")
        bookName = BehaviorRelay(value: model.title ?? "")
        bookTags = BehaviorRelay(value: model.tags ?? [])
        isFinished = BehaviorRelay(value: (model.isFineBook) == true ? "连载中" : "已完结")
    }
}
