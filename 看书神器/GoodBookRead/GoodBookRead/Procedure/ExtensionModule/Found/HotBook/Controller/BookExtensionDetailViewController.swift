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
    
    var observation:NSKeyValueObservation?
    
    let bag = DisposeBag()
    var detailParams: BookeDetailParams?
    
    private lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.separatorStyle = .none
        tw.backgroundColor = UIColor.clear
        tw.showsVerticalScrollIndicator = false
        tw.showsHorizontalScrollIndicator = false
        tw.decelerationRate = UIScrollViewDecelerationRateFast
        view.addSubview(tw)
        return tw
    }()
    
    lazy var tableHeader = UIView()
    
    lazy var viewModel: HotBookViewModel = HotBookViewModel()
    
    var bar: NavGationLargeBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.driverData(input: (view: tableView, requestData: detailParams!), depency: (action: self, bag: bag))
    }
    
    convenience init(params:BookeDetailParams) {
        self.init()
        self.detailParams = params
    }
    
    override func configUI() {
        self.bar = NavGationLargeBar.init(text: self.detailParams?.selfTitle ?? "")
        if let barView = bar {
            barView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 70)
            view.addSubview(barView)
            tableHeader.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 70)
            tableView.tableHeaderView = tableHeader
            tableView.snp.makeConstraints{
                $0.edges.equalToSuperview()
            }
        }
        //使用kvo来监听视图偏移量变化
        observation = self.tableView.observe(\.contentOffset, options: [.new, .old]) {
            [weak self] tableView, changed in
            guard let `self` = self else { return }
            if let y = changed.newValue?.y {
                if y > 70 {
                    if self.tableView.mj_header != nil {
                        self.tableView.asunHead.isHidden = true
                    }
                    UIView.animate(withDuration: 0.1, animations: {
                        self.title = self.detailParams?.selfTitle ?? ""
                    })
                } else if y == 0 || y > -30{
                    if self.tableView.mj_header != nil {
                        self.tableView.asunHead.isHidden = true
                    }
                    self.title = ""
                } else if y < -40 {
                    if self.tableView.mj_header != nil {
                        self.tableView.asunHead.isHidden = false
                    }
                }
            }
        }
    }
    
    override func configNavigationBar() {
        super.configNavigationBar()
        navigationController?.barStyle(.theme)
    }
    
    override func configDisApper() {
     
    }
}

extension BookExtensionDetailViewController: ActionExtensionProtocol {
    func didSelected(data: Any) {
        let requestData = data as! String
        let bookDetailVc = BookDetailViewController(id: requestData)
        self.navigationController?.pushViewController(bookDetailVc, animated: true)
    }
}
