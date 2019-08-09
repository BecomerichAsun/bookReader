//
//  ExtensionViewModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/1.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ExtensionViewModel: NSObject {
    
    /// 数据源
    lazy var dataSource:BehaviorRelay<ParentViewModule?> = BehaviorRelay(value: nil)

    lazy var endHeaderRefreshing: Observable<Bool> = Observable.from(optional: nil)

    lazy var endReloading: Observable<Bool> = Observable.from(optional: nil)

    lazy var homeListSource: Observable<ParentExtensionModule> = Observable.from(optional: nil)

    private lazy var headerTextArray:[String] = ["男生",
                                                 "女生",
                                                 "趣味",
                                                 "文学"]

    func driverData(inputView: UICollectionView, depency:(action: ActionExtensionProtocol, bag: DisposeBag)){

        configCollectionView(view: inputView, bag: depency.bag)

        self.homeListSource = ExtensionNetworkService.requestData()

        self.homeListSource.subscribe(onNext: { [weak self] (value) in
            guard let `self` = self else { return }
            self.dataSource.accept(ParentViewModule(module: value))
        }, onError: { (_) in
            self.dataSource.accept(nil)
            inputView.asunempty?.allowShow = true
            inputView.rx.beginReloadData.onNext(true)
        }).disposed(by: depency.bag)

        self.endReloading = self.dataSource.map{_ in true}

        self.endReloading.bind(to: inputView.rx.beginReloadData).disposed(by: depency.bag)

        self.endHeaderRefreshing = self.dataSource.map{_ in true}

        self.endHeaderRefreshing.bind(to: inputView.asunHead.rx.endRefreshing).disposed(by: depency.bag)

        //   点击Cell传值
        inputView.rx.itemSelected.asDriver().drive(onNext: { [weak self] (indexPath) in
            guard let `self` = self else { return }
            if indexPath.section == 0 {
                depency.action.didSelected(data: ((self.dataSource.value?.male![indexPath.item])!),extensionName: "male")
            } else if indexPath.section == 1 {
                depency.action.didSelected(data: ((self.dataSource.value?.female![indexPath.item])!),extensionName: "female")
            } else if indexPath.section == 2  {
                depency.action.didSelected(data: ((self.dataSource.value?.picture![indexPath.item])!),extensionName: "picture")
            } else {
                depency.action.didSelected(data: ((self.dataSource.value?.press![indexPath.item])!),extensionName: "press")
            }
        }).disposed(by: depency.bag)
    }


    /// 设置UI属性
    ///
    /// - Parameter view: CollectionView
    func configCollectionView(view: UICollectionView,bag:DisposeBag) {
        view.delegate = self
        view.dataSource = self
        view.register(supplementaryViewType: ExtensionHeaderView.self, ofKind: UICollectionElementKindSectionHeader)
        view.register(cellType: ParentExtensionCollectionViewCell.self)

        view.asunempty = AsunEmptyView{
            view.asunHead.beginRefreshing()
        }

        AppdelegateReachabilityStatus.subscribe(onNext: { (value) in
            if !(value ?? false) {
                view.asunempty?.titleString = ResultTips.network.rawValue
            } else {
                view.asunempty?.titleString = ResultTips.service.rawValue
            }
        }).disposed(by: bag)

        view.asunHead = AsunRefreshHeader{ [weak self] in
            guard let `self` = self else { return }
            self.homeListSource = ExtensionNetworkService.requestData()
            self.homeListSource.subscribe({ (event) in
                switch event {
                case .next(let element):
                    self.dataSource.accept(ParentViewModule(module: element))
                case .error:
                    self.dataSource.accept(nil)
                    view.asunempty?.allowShow = true
                    view.asunHead.rx.endRefreshing.onNext(true)
                    view.rx.beginReloadData.onNext(true)
                    break
                case .completed:
                    break
                }
            }).disposed(by: bag)
        }
    }
}

extension ExtensionViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return dataSource.value?.male?.count ?? 0
        } else if section == 1 {
            return dataSource.value?.female?.count ?? 0
        } else if section == 2 {
            return dataSource.value?.picture?.count ?? 0
        } else {
            return dataSource.value?.press?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ParentExtensionCollectionViewCell
        if indexPath.section == 0 {
            dataSource.value?.male?[indexPath.item].driverToCell(cell: cell)
        } else if indexPath.section == 1 {
            dataSource.value?.female?[indexPath.item].driverToCell(cell: cell)
        } else if indexPath.section == 2 {
            dataSource.value?.picture?[indexPath.item].driverToCell(cell: cell)
        } else {
            dataSource.value?.press?[indexPath.item].driverToCell(cell: cell)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(Double(screenWidth - 45.0) / 3.0)
        return CGSize(width: width, height: width * 0.75 + 110)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return (self.dataSource.value?.male?.count ?? 0) > 0 ? CGSize(width: screenWidth - 20, height: 34) : CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, for: indexPath, viewType: ExtensionHeaderView.self)
        head.setHeaderProprety(headerTextArray[indexPath.section], imgName: "\(indexPath.section)")
        return head
    }
}
