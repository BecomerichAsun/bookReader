//
//  BookDetailViewController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/29.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit

class BookDetailViewController: AsunBaseViewController {

    var id:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        request()
    }
    convenience init(id:String) {
        self.init()
        self.id = id
    }
}

extension BookDetailViewController {
    private func request() {
        Network.request(true, AsunAPI.bookInfo(id: id), BookIdDetailModule.self, success: { (value) in
        }, error: { (_) in

        }) { (_) in

        }
    }
}
