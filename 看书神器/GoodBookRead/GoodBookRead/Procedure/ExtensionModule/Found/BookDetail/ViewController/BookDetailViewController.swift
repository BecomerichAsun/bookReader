//
//  BookDetailViewController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/29.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit


class BookDetailViewController: AsunBaseViewController {

    var bookDetailModule:BookIdDetailModule?
//    let detailView: DetailTopView = DetailTopView.creatDetailTopView()
    var id:String = ""
    
    var image: UIImage = UIImage()

    var observation:NSKeyValueObservation?

//    var tableView:UITableView = {
//        let tw = UITableView()
//        tw.showsVerticalScrollIndicator = false
//        tw.showsHorizontalScrollIndicator = false
//        tw.scrollsToTop = true
//        tw.backgroundColor = UIColor.background
//        tw.decelerationRate = UIScrollViewDecelerationRateFast
//        return tw
//    }()
    
    let topView: BookDetailTopView = BookDetailTopView.asunCreat

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.request()
        view.addSubview(topView)
        topView.bookBackGroundImageView.image = image
        topView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(225)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        observation?.invalidate()
    }

    convenience init(id:String) {
        self.init()
        self.id = id
    }

    override func configUI() {
        

    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationController?.barStyle(.clear)
    }
}

extension BookDetailViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }


}

extension BookDetailViewController {

}

