//
//  FoundExtensionViewModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/1.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx

struct ExtensionCellViewModel {
    let bag:DisposeBag = DisposeBag()
    var bookCount: BehaviorRelay<Int>
    var icon: BehaviorRelay<String>
    var monthlyCount: BehaviorRelay<Int>
    var name: BehaviorRelay<String>
    var bookCover: BehaviorRelay<String>
}

extension ExtensionCellViewModel {
    
    /// 实例化对象
    ///
    /// - Parameter model: 单个Cell数据模型
    init(foundData model: ExtensionModule) {
        bookCount = BehaviorRelay(value: model.bookCount)
        icon = BehaviorRelay(value: model.icon)
        monthlyCount = BehaviorRelay(value: model.monthlyCount)
        name = BehaviorRelay(value: model.name)
        bookCover = BehaviorRelay(value: staticResources + (model.bookCover.first ?? ""))
    }

    func driverToCell(cell: ParentExtensionCollectionViewCell ) {
        name.asDriver().drive(cell.extensionTitleLabel.rx.text).disposed(by: bag)
        bookCover.asDriver().drive(cell.extensionImageView.rx.webImage).disposed(by: bag)
    }
}
