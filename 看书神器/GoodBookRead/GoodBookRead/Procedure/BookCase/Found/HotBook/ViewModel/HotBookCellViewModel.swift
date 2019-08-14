//
//  HotBookCellViewModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/2.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// -- 分类详情
//struct BookDetailModule:HandyJSON {
//    var total: Int = 0
//    var books: [BooksModule]?
//    var ok: Bool = false
//}

struct HotBookCellViewModel {
    let bag = DisposeBag()
    var authorSize: BehaviorRelay<CGSize>
    var hotSize: BehaviorRelay<CGFloat>
    var authorName: BehaviorRelay<String>
    var bookName: BehaviorRelay<String>
    var extensionName: BehaviorRelay<String>
    var contentName: BehaviorRelay<String>
    var countName: BehaviorRelay<String>
    var coverName: BehaviorRelay<String>
    var id: BehaviorRelay<String>
}

extension HotBookCellViewModel {

    init(model: BooksModule) {
        authorName = BehaviorRelay(value: model.author ?? "")
        bookName = BehaviorRelay(value: model.title ?? "")
        extensionName = BehaviorRelay(value: model.minorCate ?? "")
        contentName = BehaviorRelay(value: model.shortIntro ?? "")
        countName = BehaviorRelay(value: "\(model.latelyFollower)")
        coverName = BehaviorRelay(value: (staticResources + (model.cover ?? "")))
        authorSize = BehaviorRelay(value: getSize(content: model.author ?? "", font: pingFangSizeLight(size: 12)).size)
        hotSize = BehaviorRelay(value: (getSize(content: model.latelyFollower , font: pingFangSizeLight(size: 10)).size.width) + 28)
        id = BehaviorRelay(value: model.id ?? "")
    }

    func driverToCell(cell: BookDetailTableViewCell ) {
        coverName.asDriver().drive(cell.bookView.rx.webImage).disposed(by: bag)
        bookName.asDriver().drive(cell.bookNameLabel.rx.text).disposed(by: bag)
        authorName.asDriver().drive(cell.bookAuthorLabel.rx.text).disposed(by: bag)
        extensionName.asDriver().drive(cell.bookExtensionLabel.rx.text).disposed(by: bag)
        contentName.asDriver().drive(cell.bookDetailLabel.rx.text).disposed(by: bag)
        hotSize.asDriver().drive(cell.bookPeopleView.rx.width).disposed(by: bag)
        authorSize.asDriver().drive(cell.bookAuthorLabel.rx.size).disposed(by: bag)
        countName.asDriver().drive(cell.bookCountLabel.rx.text).disposed(by: bag)
    }
}
