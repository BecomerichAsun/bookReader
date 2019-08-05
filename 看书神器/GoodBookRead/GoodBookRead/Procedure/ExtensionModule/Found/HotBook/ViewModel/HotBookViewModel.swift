//
//  hotBookViewModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/2.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
import MJRefresh

class HotBookViewModel: NSObject {

    var startCount: Int = 21

    lazy var dataSource = BehaviorRelay<[HotBookCellViewModel]>.init(value: [])

    lazy var endHeaderRefreshing: Driver<Bool> = Driver.from(optional: nil)

    lazy var endFootRefreshing: Driver<Bool> = Driver.from(optional: nil)

    func driverData(input: (view: UITableView, requestData: BookeDetailParams), depency:(action: ActionExtensionProtocol, bag: DisposeBag)) {

        configCollectionView(view: input.view)

        let headerRefreshData = input.view.asunHead.rx.refreshing.asDriver().startWith(())
            .flatMapLatest{ _ in
                return ExtensionNetworkService.requestHotBookList(params: input.requestData, start: 0)
        }

        let footerRefreshData = input.view.asunFoot.rx.refreshing.asDriver()
            .flatMapLatest{ _ in
                return ExtensionNetworkService.requestHotBookList(params: input.requestData, start: self.startCount)
        }

        headerRefreshData.drive(onNext: { [weak self] (value) in
            guard let `self` = self,value.books != nil  else { return }
            if value.books?.count == 0 {
                input.view.asunempty?.titleString = ResultTips.service.rawValue
                input.view.asunempty?.allowShow = false
                return 
            }
            self.startCount = 21
            self.dataSource.accept( (value.books?.compactMap{HotBookCellViewModel(model: $0)})!)
            input.view.reloadData()
        }).disposed(by: depency.bag)

        footerRefreshData.drive(onNext: { [weak self] (value) in
            guard let `self` = self,value.books != nil  else { return }
            self.startCount += 21
            self.dataSource.accept(self.dataSource.value + (value.books?.compactMap{HotBookCellViewModel(model: $0)})!)
            input.view.reloadData()
        }).disposed(by: depency.bag)

        endHeaderRefreshing  = headerRefreshData.map{ _ in true}

        endFootRefreshing  = footerRefreshData.map{ _ in true}

        endHeaderRefreshing.drive(input.view.asunHead.rx.endRefreshing).disposed(by: depency.bag)

        endFootRefreshing.drive(input.view.asunFoot.rx.endRefreshing).disposed(by: depency.bag)

        input.view.rx.itemSelected.subscribe(onNext: { [weak self] (indexPath) in
            guard let `self` = self else { return }
            depency.action.didSelected(data: self.dataSource.value[indexPath.row].id.value)
        }).disposed(by: depency.bag)
    }

    func configCollectionView(view: UITableView) {

        view.delegate = self
        view.dataSource = self

        view.asunempty?.allowShow = false

        view.register(cellType: BookDetailTableViewCell.self)

        view.asunFoot = AsunRefreshFooter()

        view.asunHead = AsunRefreshHeader()

        view.asunempty = AsunEmptyView(tapClosure: {

        })
    }

}

extension HotBookViewModel : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BookDetailTableViewCell.self)
        self.dataSource.value[indexPath.row].driverToCell(cell: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
