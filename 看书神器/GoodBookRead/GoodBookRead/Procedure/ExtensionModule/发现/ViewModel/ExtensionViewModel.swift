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
import RxDataSources
import Reusable
import NSObject_Rx


/// Action协议
protocol ActionExtensionProtocol: class {
        func didSelected(data: ExtensionCellViewModel, extensionName: String)
}

extension ActionExtensionProtocol {
    func didSelected(data: ExtensionCellViewModel, extensionName: String) {AsunLog("===DidSelected===")}
}

enum RefreshMode {
    case ok
    case networkError(message: String)
    case failed(message: String)
}

extension RefreshMode: CustomStringConvertible {
    var description: String {
        switch self {
        case .ok:
            return ""
        case let .networkError(message):
            return message
        case let .failed(message):
            return message
        }
    }
}


class ExtensionViewModel: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let bag = DisposeBag()
    
    weak var delegate: ActionExtensionProtocol?
    
    /// 数据源
    var dataSource: BehaviorRelay<ParentViewModule?> = BehaviorRelay.init(value: nil)

    lazy var isRefreshed: BehaviorRelay<RefreshMode> = BehaviorRelay(value: RefreshMode.ok)
    
    private lazy var headerTextArray:[String] = ["男生",
                                                 "女生",
                                                 "趣味",
                                                 "文学"]
    
    func driverData(view: UICollectionView,delegate:ActionExtensionProtocol) {
        configCollectionView(view: view)
        
        request()

        self.delegate = delegate
        
        dataSource.asDriver().drive(onNext: { (model) in
            view.reloadData(animation: true)
        }).disposed(by: bag)

        isRefreshed.asDriver().drive(onNext: { (value) in
            switch value {
            case .failed(let message):
                view.asunempty?.allowShow = true
                view.asunempty?.titleString = message
                view.asunHead.endRefreshing()
            case .ok:
                view.asunempty?.allowShow = true
                view.asunHead.endRefreshing()
                view.reloadData(animation: true)
            case .networkError(let message):
                view.asunempty?.allowShow = true
                view.asunempty?.titleString = message
                view.asunHead.endRefreshing()
            }
        }).disposed(by: bag)
        
        view.rx.itemSelected.asDriver().drive(onNext: { [weak self] (indexPath) in
            guard let `self` = self else { return }
            if let del = self.delegate {
                if indexPath.section == 0 {
                    del.didSelected(data: ((self.dataSource.value?.male![indexPath.item])!),extensionName: "male")
                } else if indexPath.section == 1 {
                    del.didSelected(data: ((self.dataSource.value?.female![indexPath.item])!),extensionName: "female")
                } else if indexPath.section == 2  {
                    del.didSelected(data: ((self.dataSource.value?.picture![indexPath.item])!),extensionName: "picture")
                } else {
                    del.didSelected(data: ((self.dataSource.value?.press![indexPath.item])!),extensionName: "press")
                }
            }
        }).disposed(by: bag)
    }
}


// MARK: - 请求
extension ExtensionViewModel {
    func request() {
        Network.request(true, AsunAPI.parentCategoryNumberOfBooks, ParentExtensionModule.self, success: { [weak self](value) in
            guard let `self` = self, value != nil else { return }
            self.dataSource.accept(ParentViewModule(module: value!))

            self.isRefreshed.accept(.ok)
            }, error: { (value) in
                self.isRefreshed.accept(.failed(message: "服务器出了点儿问题, 稍后再试~"))
        }) { (_) in
            self.isRefreshed.accept(.failed(message: "网络出现故障, 请检查网络状况~"))
        }
    }
}

// MARK: - UI-Config
extension ExtensionViewModel {
    
    /// 设置UI属性
    ///
    /// - Parameter view: CollectionView
    func configCollectionView(view: UICollectionView) {
        view.dataSource = self
        view.delegate = self
        //        下拉刷新
        view.asunHead = AsunRefreshHeader { [weak self] in
            guard let `self` = self else { return }
            self.request()
        }
        //        页面刷新
        view.asunempty = AsunEmptyView {[weak self] in
            guard let `self` = self else { return }
            self.request()
        }
        
        view.asunFoot = AsunRefreshDiscoverFooter()
        view.register(supplementaryViewType: ExtensionHeaderView.self, ofKind: UICollectionElementKindSectionHeader)
        view.register(cellType: ParentExtensionCollectionViewCell.self)
    }
    
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
