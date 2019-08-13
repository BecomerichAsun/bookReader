//
//  BookSelfModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/13.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit
import HandyJSON

struct BookSelfModel: HandyJSON {
    var status: Int = 0
    var info: String?
    var data: [BookSelfItemModel]?
}

struct BookSelfItemModel: HandyJSON {
    var author: String?
    var newChapterCount: Int = 0
    var id: Int = 0
    var chapterId: Int = 0
    var lastChapter: String?
    var chapterName: String?
    var lastChapterId: Int = 0
    var updateTime: String?
    var name: String?
    var img: String?
}

