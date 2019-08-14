//
//  BookCaseViewController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/14.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BookCaseViewController: AsunBaseViewController {

    lazy var tableView: UITableView = {
        let tw = UITableView(frame: .zero, style: .plain)
        tw.separatorStyle = .none
        tw.backgroundColor = UIColor.background
        tw.showsVerticalScrollIndicator = false
        tw.showsHorizontalScrollIndicator = false
        tw.decelerationRate = UIScrollViewDecelerationRateFast
        view.addSubview(tw)
        return tw
    }()

    private lazy var viewModel: BookCaseViewModel = BookCaseViewModel()

    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func configUI() {
        tableView.snp.makeConstraints{$0.edges.equalToSuperview()}
        viewModel.bindData(bind: tableView, depency: (action: self, bag: bag))
    }
}

extension BookCaseViewController: ActionExtensionProtocol {
    func didSelected(data: Any) {
        print(data as! BookCaseCellViewModel)
    }
}
