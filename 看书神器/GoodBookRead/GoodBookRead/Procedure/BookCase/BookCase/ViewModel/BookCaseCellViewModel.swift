//
//  BookCaseCellModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/14.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

struct BookCaseCellViewModel {
    let bag = DisposeBag()
    let chapterId: BehaviorRelay<String>
    var newChapterCount: BehaviorRelay<String>
    var bookId: BehaviorRelay<String>
    var bookName: BehaviorRelay<String>
    var bookAuthor: BehaviorRelay<String>
    var bookImage: BehaviorRelay<String>
    var lastChapterId: BehaviorRelay<String>
    var lastChapter: BehaviorRelay<String>
    var updateTime: BehaviorRelay<String>
    var isHiddenUpdate: BehaviorRelay<Bool>

    init(withBookCaseData model: BookCaseItemModel) {
        chapterId = BehaviorRelay(value: "\(model.chapterId)")
        newChapterCount = BehaviorRelay(value: "\(model.newChapterCount)")
        bookId = BehaviorRelay(value: "\(model.id)")
        bookName = BehaviorRelay(value: model.name ?? "")
        bookAuthor = BehaviorRelay(value: model.author ?? "")
        bookImage = BehaviorRelay(value: RequestService.donwondURl + (model.img ?? ""))
        lastChapterId = BehaviorRelay(value: "\(model.lastChapterId)")
        lastChapter = BehaviorRelay(value: "最新: " + (model.lastChapter ?? ""))
        updateTime = BehaviorRelay(value: model.updateTime ?? "")
        isHiddenUpdate = BehaviorRelay(value: model.isUpdate)
    }
}

extension BookCaseCellViewModel {
    func driver(withBookCaseCell cell: BookCaseTableViewCell) {
        bookName.asDriver().drive(cell.bookNameLabel.rx.text).disposed(by: bag)
        bookAuthor.asDriver().drive(cell.bookAuthorLabel.rx.text).disposed(by: bag)
        lastChapter.asDriver().drive(cell.bookUpdateTextLabel.rx.text).disposed(by: bag)
        updateTime.asDriver().drive(cell.bookUpdateTimeLabel.rx.text).disposed(by: bag)
        bookImage.asDriver().drive(cell.bookView.rx.webImage).disposed(by: bag)
        isHiddenUpdate.asDriver().drive(cell.gradientView.rx.isHidden).disposed(by: bag)
    }
}
