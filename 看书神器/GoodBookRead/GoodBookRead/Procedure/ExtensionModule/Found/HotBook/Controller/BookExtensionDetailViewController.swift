//
//  BookDetailViewController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/28.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa



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

class BookExtensionDetailViewController: AsunBaseViewController {


    let bag = DisposeBag()
    var detailParams: BookeDetailParams?

    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.separatorStyle = .none
        tw.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        tw.showsVerticalScrollIndicator = false
        tw.showsHorizontalScrollIndicator = false
        tw.decelerationRate = UIScrollViewDecelerationRateFast
        view.addSubview(tw)
        return tw
    }()

    lazy var viewModel: HotBookViewModel = HotBookViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.driverData(input: (view: tableView, requestData: detailParams!), depency: (action: self, bag: bag))
    }

    convenience init(params:BookeDetailParams) {
        self.init()
        self.detailParams = params
        self.title = params.selfTitle
    }

    override func configUI() {
        tableView.snp.makeConstraints{$0.edges.equalTo(view.usnp.edges)}
    }
}

extension BookExtensionDetailViewController: ActionExtensionProtocol {
    func didSelected(data: Any) {
        let requestData = data as! String
        let bookDetailVc = BookDetailViewController(id: requestData)
        self.navigationController?.pushViewController(bookDetailVc, animated: true)
    }
}
