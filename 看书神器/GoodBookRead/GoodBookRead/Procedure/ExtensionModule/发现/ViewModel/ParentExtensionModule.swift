//
//  Model.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/1.
//  Copyright © 2019 Asun. All rights reserved.
//

import HandyJSON
import RxDataSources

///  -- 分类
struct ParentExtensionModule: HandyJSON {
    var male:[ExtensionModule]?
    var female:[ExtensionModule]?
    var picture:[ExtensionModule]?
    var press:[ExtensionModule]?
}

struct ParentViewModule {
    
    var male:[ExtensionCellViewModel]?
    var female:[ExtensionCellViewModel]?
    var picture:[ExtensionCellViewModel]?
    var press:[ExtensionCellViewModel]?
    
    init(module: ParentExtensionModule) {
        self.male = (module.male?.compactMap{ExtensionCellViewModel(foundData: $0)})!
        self.female = (module.female?.compactMap{ExtensionCellViewModel(foundData: $0)})!
        self.picture = (module.picture?.compactMap{ExtensionCellViewModel(foundData: $0)})!
        self.press = (module.press?.compactMap{ExtensionCellViewModel(foundData: $0)})!
    }
}

/// -- 分类单个Cell数据
struct ExtensionModule: HandyJSON {
    
    var bookCount: Int
    var icon: String
    var monthlyCount: Int
    var name: String
    var bookCover: [String]
    
    init() {
        bookCount = 0
        icon = ""
        monthlyCount = 0
        name = ""
        bookCover = []
    }
}
