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
    var maleExtension:String = "male"
    var femaleExtension:String = "female"
    var pictureExtension:String = "picture"
    var pressExtension:String = "press"
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
            image = staticResources + (bookCover?[0] ?? "")
        }
        return image
    }
}

/// -- 分类详情
struct BookDetailModule:HandyJSON {
    var total: Int = 0
    var books: [BooksModule]?
    var ok: Bool = false
}

struct BooksModule :HandyJSON {
    var sizetype: Int = 0
    var majorCate: String?
    var minorCate: String?
    var superscript: String?
    var banned: Int = 0
    var author: String?
    var retentionRatio: CGFloat = 0.0
    var contentType: String?
    var id: String?
    var allowMonthly: Bool = false
    var title: String?
    var tags: [String]?
    var latelyFollower: Int = 0
    var cover: String?
    var lastChapter: String?
    var site: String?
    var shortIntro: String?
    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.id <-- "_id"
    }
}

/// -- 书籍详情
struct BookIdDetailModule: HandyJSON {
    var safelevel: Int = 0
    var author: String?
    var _id: String?
    var postCount: Int = 0
    var cat: String?
    var currency: Int = 0
    var allowFree: Bool = false
    var authorDesc: String?
    var allowMonthly: Bool = false
    var retentionRatio: String?
    var latelyFollower: Int = 0
    var allowBeanVoucher: Bool = false
    var updated: String?
    var lastChapter: String?
    var _gg: Bool = false
    var wordCount: Int = 0
    var isForbidForFreeApp: Bool = false
    var majorCate: String?
    var minorCate: String?
    var contentType: String?
    var advertRead: Bool = false
    var limit: Bool = false
    var cover: String?
    var superscript: String?
    var banned: Int = 0
    var isFineBook: Bool = false
    var buytype: Int = 0
    var chaptersCount: Int = 0
    var sizetype: Int = 0
    var copyrightDesc: String?
    var creater: String?
    var followerCount: Int = 0
    var tags: [String]?
    var longIntro: String?
    var hasCp: Bool = false
    var gender: [String]?
    var donate: Bool = false
    var allowVoucher: Bool = false
    var originalAuthor: String?
    var serializeWordCount: Int = 0
    var majorCateV2: String?
    var _le: Bool = false
    var title: String?
    var isSerial: Bool = false
    var minorCateV2: String?
    var hasCopyright: Bool = false
    var isAllowNetSearch: Bool = false
    var discount: String?

}

