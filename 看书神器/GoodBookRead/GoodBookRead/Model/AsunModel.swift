//
//  BookDetailModule.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/28.
//  Copyright © 2019年 Asun. All rights reserved.
//

import HandyJSON


///  -- 分类Tab
struct ParentExtensionModule: HandyJSON {
    var male:[ExtensionModule]?
    var female:[ExtensionModule]?
    var picture:[ExtensionModule]?
    var press:[ExtensionModule]?
    var ok: Bool = false
}

/// -- 分类单个
struct ExtensionModule: HandyJSON {
    var bookCount: Int = 0
    var icon: String?
    var monthlyCount: Int = 0
    var name: String?
    var bookCover: [String]?

    mutating func creatImg() -> String {
        var image:String = ""
        if bookCover?.count ?? 0 > 0 {
            image = "http://statics.zhuishushenqi.com" + (bookCover?[0] ?? "")
        }
        return image
    }
}

/// -- 书籍详情
struct BookDetailModule:HandyJSON {
    var total: Int = 0
    var books: [Books]?
    var ok: Bool = false
}

struct Books :HandyJSON {
    var sizetype: Int = 0
    var majorCate: String?
    var minorCate: String?
    var superscript: String?
    var banned: Int = 0
    var author: String?
    var retentionRatio: CGFloat = 0.0
    var contentType: String?
    var _id: String?
    var allowMonthly: Bool = false
    var title: String?
    var tags: [String]?
    var latelyFollower: Int = 0
    var cover: String?
    var lastChapter: String?
    var site: String?
    var shortIntro: String?
}

