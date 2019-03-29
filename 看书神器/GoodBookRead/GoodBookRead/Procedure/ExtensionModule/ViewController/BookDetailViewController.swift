//
//  BookDetailViewController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/28.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit
import MBProgressHUD
import YYAsyncLayer
// 请求参数
struct BookeDetailParams {
    init() { }
    var gender:String = ""
    var major:String = ""
    var start:Int = 0
    var limit:Int = 20
    var selfTitle:String = ""
    init(_ gender:String, _ major:String, _ start:Int, _ limit:Int, _ title:String) {
        self.gender = gender
        self.major = major
        self.start = start
        self.limit = limit
        self.selfTitle = title
    }

    mutating func updateRequest(strat:Int) {
        self.start = strat
    }
}

class BookDetailViewController: AsunBaseViewController {

    var detailModule: BookDetailModule?

    var detailParams: BookeDetailParams?

    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.delegate = self
        tw.dataSource = self
        tw.separatorStyle = .none
        tw.backgroundColor = UIColor.background
        tw.showsVerticalScrollIndicator = false
        tw.showsHorizontalScrollIndicator = false
        tw.register(cellType: BookDetailTableViewCell.self)
        tw.asunHead = AsunRefreshHeader { [weak self] in
            guard let `self` = self else { return }
            self.request()
        }
        tw.asunempty = AsunEmptyView(verticalOffset: -(tw.contentInset.top)) {self.request()}
        return tw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        request()
    }

    convenience init(params:BookeDetailParams) {
     self.init()
     self.detailParams = params
     self.title = self.detailParams?.selfTitle ?? ""
    }

    override func configUI() {
        tableView.asunFoot = AsunRefreshFooter(refreshingBlock: {[weak self] in
            guard let `self` = self else { return }
            let start = ((self.detailParams?.start ?? 0) + 21)
            self.detailParams?.updateRequest(strat: start)
            self.requestFooter(start: start)
        })
        view.addSubview(tableView)
        tableView.snp.makeConstraints{$0.edges.equalTo(view.usnp.edges)}
    }
}

extension BookDetailViewController {
    private func request() {
        Network.request(true, AsunAPI.classificationDetails(gender: detailParams?.gender ?? "", major: detailParams?.major ?? "", start: 0, limit: 20),BookDetailModule.self , success: { [weak self](value) in
            guard let `self` = self else { return }
            if self.detailModule?.books?.count ?? 0 > 0 {
                self.detailModule?.books?.removeAll()
            }
            self.tableView.asunHead.endRefreshing()
            self.detailModule = value
            self.detailModule?.books?.sort(by: { (firstModel, lastModel) -> Bool in
                return firstModel.latelyFollower > lastModel.latelyFollower
            })
            self.tableView.reloadData()
        }, error: { (value) in
            self.tableView.asunHead.endRefreshing()
        }) { (error) in
            self.tableView.asunHead.endRefreshing()
        }
    }

    private func requestFooter(start:Int) {
        Network.request(true, AsunAPI.classificationDetails(gender: detailParams?.gender ?? "", major: detailParams?.major ?? "", start:start, limit: 20),BookDetailModule.self , success: { [weak self](value) in
            guard let `self` = self else { return }
            if value?.books?.count ?? 0 > 0{
            self.tableView.asunFoot.endRefreshing()
                value?.books?.forEach({ (model) in
                    self.detailModule?.books?.append(model)
                })
                self.tableView.reloadData()
            } else {
                self.tableView.asunFoot.endRefreshingWithNoMoreData()
            }
            }, error: { (value) in
                self.tableView.asunFoot.endRefreshing()
        }) { (error) in
            self.tableView.asunFoot.endRefreshing()
        }
    }
}

extension BookDetailViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.detailModule?.books?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BookDetailTableViewCell.self)
        cell.model = self.detailModule?.books?[indexPath.row] ?? BooksModule()
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        YYTransaction.init(target: self, selector: #selector(updateTransaction)).commit()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    @objc func updateTransaction() {
        self.tableView.layer.setNeedsDisplay()
    }
}
