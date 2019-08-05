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
    let detailView: DetailTopView = DetailTopView.creatDetailTopView()
    var id:String = ""

    var observation:NSKeyValueObservation?

    var tableView:UITableView = {
        let tw = UITableView()
        tw.showsVerticalScrollIndicator = false
        tw.showsHorizontalScrollIndicator = false
        tw.scrollsToTop = true
        tw.backgroundColor = UIColor.background
        tw.decelerationRate = UIScrollViewDecelerationRateFast
        return tw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.request()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //使用kvo来监听视图偏移量变化
        observation = self.tableView.observe(\.contentOffset, options: [.new, .old]) {
            [weak self] tableView, changed in
            guard let `self` = self else { return }
            if changed.newValue!.y > (getSize(content: self.detailView.bookName.text ?? "", font: pingFangSizeMedium(size: 23)).height + 10) {
                UIView.animate(withDuration: 0.3, animations: {
                    self.title = self.bookDetailModule?.title ?? ""
                })
            } else {
                    self.title =  ""
            }
        }
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
        view.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.edges.equalTo(self.view.usnp.edges)
        }
        tableView.tableHeaderView = detailView
    }
}

extension BookDetailViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

    }


}

extension BookDetailViewController {
    private func request() {
//        Network.request(true, AsunAPI.bookInfo(id: id), BookIdDetailModule.self, success: { [weak self](value) in
//            guard let `self` = self else { return }
//            self.bookDetailModule = value
//            guard let module = self.bookDetailModule  else {
//                return
//            }
//            self.detailView.viewModel = DetailViewModel(model: module)
//            })
    }
}
