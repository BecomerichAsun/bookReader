//
//  BookCaseViewModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/14.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RealmSwift

class BookCaseViewModel: NSObject {

    lazy var caseListSource: Observable<BookCaseModel> = Observable.from(optional: nil)

    var saveDataSource: BehaviorRelay<[BookCaseCellViewModel]> = BehaviorRelay(value: [])

    var dataSource: BehaviorRelay<[BookCaseCellViewModel]> = BehaviorRelay(value: [])

    lazy var endHeaderRefreshing: Observable<Bool> = Observable.from(optional: nil)

    lazy var endReloading: Observable<Bool> = Observable.from(optional: nil)

    func bindData(bind view: UITableView, depency:(action: ActionExtensionProtocol, bag: DisposeBag)) {
        configTableView(view: view, action: depency.action, bag: depency.bag)
        requestData(view: view, bag: depency.bag)
    }
}

extension BookCaseViewModel {
    private func requestData(view: UITableView, bag: DisposeBag) {

        self.caseListSource = RequestService.requestLocalBook(isLoading: true)

        self.caseListSource.subscribe(onNext: { [weak self] (model) in
            guard let `self` = self else { return }
            if model.status == 1 && model.data?.count ?? 0 > 0{
                if RealmManager.getObject(type: BookCaseItemModel.self).count > 0 {
//RealmManager.getObject(type: BookCaseItemModel.self).compactMap{return BookCaseCellViewModel(withBookCaseData: $0)}
                    RealmManager.getObject(type: BookCaseItemModel.self).map{print($0)}
                    //                    self.dataSource.accept()
                } else {
                    RealmManager.writeArray(data: model.data!)
                    self.dataSource.accept((model.data?.compactMap{return BookCaseCellViewModel(withBookCaseData: $0)})!)
                }
            } else {
                view.asunempty?.titleString = "书架空空如也~"
                view.asunempty?.allowShow = true
                view.asunHead.rx.endRefreshing.onNext(true)
            }
            }, onError: { (_) in
                self.dataSource.accept([])
                view.asunempty?.allowShow = true
                view.asunHead.rx.endRefreshing.onNext(true)
                view.rx.beginReloadData.onNext(true)
        }).disposed(by: bag)

        self.endReloading = self.dataSource.map{_ in true}
        self.endReloading.bind(to: view.rx.beginReloadData).disposed(by: bag)
        self.endHeaderRefreshing = self.dataSource.map{ _ in true }
        self.endHeaderRefreshing.bind(to: view.asunHead.rx.endRefreshing).disposed(by: bag)
    }

    private func configTableView(view: UITableView, action: ActionExtensionProtocol, bag: DisposeBag) {
        view.delegate = self
        view.register(BookCaseTableViewCell.self, forCellReuseIdentifier: "BookCaseTableViewCellId")

        view.asunHead = AsunRefreshHeader { [weak self] in
            guard let `self` = self else { return }
            self.caseListSource = RequestService.requestLocalBook(isLoading: false)
            self.caseListSource.subscribe(onNext: { [weak self] (model) in
                guard let `self` = self else { return }
                if model.status == 1 && model.data?.count ?? 0 > 0{
                    if RealmManager.getObject(type: BookCaseItemModel.self).count > 0 {
                       self.dataSource.accept(RealmManager.getObject(type: BookCaseItemModel.self).compactMap{return BookCaseCellViewModel(withBookCaseData: $0)})
                    } else {
                        RealmManager.writeArray(data: model.data!)
                    }
//                    let sortModel = model
//                    sortModel.data?.sort(by: { (value1, value2) -> Bool in
//                        return value1.newChapterCount > value2.newChapterCount
//                    })
//                    self.dataSource.accept((sortModel.data?.compactMap{return BookCaseCellViewModel(withBookCaseData: $0)})!)
                } else {
                    view.asunempty?.titleString = "书架空空如也~"
                    view.asunempty?.allowShow = true
                    view.asunHead.rx.endRefreshing.onNext(true)
                }
                }, onError: { (error) in
                    self.dataSource.accept([])
                    view.asunempty?.allowShow = true
                    view.asunHead.rx.endRefreshing.onNext(true)
                    view.rx.beginReloadData.onNext(true)
            }).disposed(by: bag)
        }

        view.asunempty = AsunEmptyView {
            view.asunHead.beginRefreshing()
        }

        view.asunempty?.allowShow = false

        AppdelegateReachabilityStatus.subscribe(onNext: { (value) in
            if !(value ?? false) {
                view.asunempty?.titleString = ResultTips.network.rawValue
            } else {
                view.asunempty?.titleString = ResultTips.service.rawValue
            }
        }).disposed(by: bag)

        self.dataSource.asObservable().bind(to: view.rx.items(cellIdentifier: "BookCaseTableViewCellId", cellType: BookCaseTableViewCell.self)) { (row, element, cell) in
            element.driver(withBookCaseCell: cell)
            }.disposed(by: bag)

        view.rx.itemSelected.subscribe(onNext: { [weak self] (indexPath) in
            guard let `self` = self else { return }
            action.didSelected(data: self.dataSource.value[indexPath.row])
        }).disposed(by: bag)
    }
}

extension BookCaseViewModel: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

