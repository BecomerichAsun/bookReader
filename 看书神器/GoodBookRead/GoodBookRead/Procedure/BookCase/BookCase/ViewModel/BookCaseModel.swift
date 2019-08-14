//
//  BookSelfModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/13.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit
import HandyJSON

struct BookCaseModel: HandyJSON {
    var status: Int = 0
    var info: String?
    var data: [BookCaseItemModel]?
}

struct BookCaseItemModel: HandyJSON {
    var author: String?
    var newChapterCount: Int = 0
    var id: Int = 0
    var chapterId: Int = 0
    // 最新章节
    var lastChapter: String?
    var chapterName: String?
    var lastChapterId: Int = 0
    var updateTime: String?
    var name: String?
    var img: String?

    mutating func mapping(mapper: HelpingMapper) {
        mapper <<<
            self.updateTime <-- "UpdateTime"
        mapper <<<
            self.lastChapter <-- "LastChapter"
        mapper <<<
            self.lastChapterId <-- "LastChapterId"
        mapper <<<
            self.img <-- "Img"
        mapper <<<
            self.author <-- "Author"
        mapper <<<
            self.name <-- "Name"
        mapper <<<
            self.id <-- "Id"
        mapper <<<
            self.newChapterCount <-- "NewChapterCount"
        mapper <<<
            self.chapterName <-- "ChapterName"
        mapper <<<
            self.chapterId <-- "ChapterId"
    }
}

//{"ChapterId":0,"ChapterName":"","NewChapterCount":0,"Id":8975,"Name":"全职法师","Author":"乱","Img":"quanzhifashi.jpg","LastChapterId":5573411,"LastChapter":"第3055章 手下留情了","UpdateTime":"2019/08/14 08:57:57"}]}
