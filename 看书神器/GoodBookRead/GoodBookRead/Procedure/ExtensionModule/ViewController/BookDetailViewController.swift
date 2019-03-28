//
//  BookDetailViewController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/28.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit

class BookDetailViewController: AsunBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        request()
    }

    override func configUI() {
        
    }
}

extension BookDetailViewController {
    private func request() {
        Network.request(true, AsunAPI.classificationDetails(gender: "male", major: "玄幻", start:0, limit: 20),BookDetailModule.self , success: { (value) in
            print(value)
        }, error: { (value) in

        }) { (error) in

        }
    }
}
