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

class HotBookViewModel: AsunTableViewModel {

    var detailParams: BookeDetailParams?

    lazy var dataSource: BehaviorRelay<[HotBookCellViewModel]?> = BehaviorRelay(value: nil)

    var count: Int = 0

    func driverData<T: Any>(view: UITableView, requestData: T ,action: ActionExtensionProtocol) {
        self.driverViewModel(view: view, requestData: requestData, refresh: ["HeaderRefresh" : false , "FooterRefresh" : false], actionProtocol: action) {
            [weak self] in
            guard let `self` = self else { return }
            self.detailParams = requestData as? BookeDetailParams
            self.count = self.detailParams?.start ?? 0

            dataSource.asDriver().drive(onNext: { (value) in
                view.reloadData()
            }).disposed(by: bag)

            view.rx.itemSelected.subscribe(onNext: { [weak self] (indexPath) in
                guard let `self` = self else { return }
                if let del = self.deleagte {
                    del.didSelected(data: self.dataSource.value?[indexPath.row].id.value ?? "0")
                }
            }).disposed(by: bag)
        }
    }

    override func configCollectionView(view: UITableView, data: Any) {

        view.delegate = self
        view.dataSource = self
        view.asunempty?.allowShow = false
        detailParams = data as? BookeDetailParams

        view.register(cellType: BookDetailTableViewCell.self)

        view.asunFoot = AsunRefreshFooter(refreshingBlock: { [weak self] in
            guard let `self` = self else { return }
            self.count += 21
            self.detailParams?.updateRequest(strat: self.count)
            self.requestList(nextPage: true)
        })

        view.asunHead = AsunRefreshHeader { [weak self] in
            guard let `self` = self else { return }
            self.count = 0
            self.detailParams?.updateRequest(strat: 0)
            self.requestList(nextPage: false)
        }
    }

    override func requestList(nextPage: Bool) {
        Network.request(true, AsunAPI.classificationDetails(gender: detailParams?.gender ?? "", major: detailParams?.major ?? "", start: self.detailParams?.start ?? 0, limit: 20), BookDetailModule.self , success: { [weak self](value) in
            guard let `self` = self else { return }
            if !(value?.ok ?? false) {
                self.acceptRefresh(status: .noMoreData)
                self.detailParams?.updateRequest(strat: 0)
                return
            }

            if nextPage {
                if self.dataSource.value?.count ?? 0 > 0{
                    self.dataSource.accept(self.dataSource.value! + (value?.books?.compactMap{HotBookCellViewModel(model: $0)})!)
                }
            } else {
                self.dataSource.accept(value?.books?.compactMap{HotBookCellViewModel(model: $0)})
            }
            self.acceptRefresh(status: .ok)
            }, error: { (_) in
                self.acceptRefresh(status:.failed(message: ResultTips.service.rawValue))
        }) { (_) in
            self.acceptRefresh(status:.networkError(message: ResultTips.network.rawValue))
        }
    }
}

extension HotBookViewModel : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.value?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BookDetailTableViewCell.self)
        self.dataSource.value?[indexPath.row].driverToCell(cell: cell)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
