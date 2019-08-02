//
//  AsunCollectionViewModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/2.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

@objcMembers class AsunTableViewModel: NSObject, ActionExtensionProtocol {
    
    /// Push等操作闭包别名
    typealias action = ()->()
    
    let bag = DisposeBag()
    
    lazy var isRefreshed: BehaviorRelay<RefreshMode> = BehaviorRelay(value: RefreshMode.ok)
    
    weak var deleagte: ActionExtensionProtocol?
    
    final func driverViewModel(view: UITableView, requestData: Any, refresh: [String : Bool]? = ["HeaderRefresh" : true, "FooterRefresh" : true], actionProtocol : ActionExtensionProtocol, actionCallBack: action) {
        driverData(with: view, requestData: requestData, refresh: refresh, data: requestData, actionProtocol: actionProtocol, actionCallBack: actionCallBack)
    }
}

extension AsunTableViewModel {
    
    /// 设置控件基本属性 创建订阅 初始化等
    ///
    /// - Parameters:
    ///   - view: 操作的View
    ///   - refresh: 是否需要刷新控件 HeaderRefresh 头部 FooterRefresh 尾部 默认含有无数据页面
    ///   - actionProtocol: 跳转代理
    ///   - actionCallBack: 继承后续操作闭包回调
    private func driverData(with view: UITableView, requestData: Any, refresh: [String : Bool]? = ["HeaderRefresh" : true, "FooterRefresh" : true], data: Any, actionProtocol : ActionExtensionProtocol , actionCallBack: action) {
        
        self.deleagte = actionProtocol
        
        if refresh!.keys.contains("FooterRefresh") && refresh!.keys.contains("HeaderRefresh") {
            ifNeedRefresh(header: refresh!["HeaderRefresh"]!, footer: refresh!["FooterRefresh"]!, view: view)
        } else if refresh!.keys.contains("HeaderRefresh") {
            ifNeedRefresh(header: refresh!["HeaderRefresh"]!, footer: false, view: view)
        } else  if refresh!.keys.contains("FooterRefresh") {
            ifNeedRefresh(header: false, footer: refresh!["FooterRefresh"]!, view: view)
        }

        configCollectionView(view: view, data: requestData)
        
        driveRefresh(view: view)
        
        actionCallBack()
        
        requestList(nextPage: false)
    }
    
    /// 请求
   func requestList(nextPage: Bool) {}
    
    /// 设置基本属性
    func configCollectionView(view: UITableView, data: Any) { }
    
    /// 更新刷新控件状态
    ///
    /// - Parameter status: 控件状态
    func acceptRefresh(status: RefreshMode) {
        isRefreshed.accept(status)
    }
    
    /// 刷新控件
    ///
    /// - Parameters:
    ///   - header: 是否有头部
    ///   - footer: 是否有尾部
    private func ifNeedRefresh(header: Bool, footer: Bool, view: UITableView) {
        if header {
            view.asunHead = AsunRefreshHeader { [weak self] in
                guard let `self` = self else { return }
                self.requestList(nextPage: false)
            }
        }
        view.asunempty = AsunEmptyView {[weak self] in
            guard let `self` = self else { return }
            self.requestList(nextPage: true)
        }
        if footer {
            view.asunFoot = AsunRefreshDiscoverFooter()
        }
    }
    
    /// 订阅刷新控件状态
    private func driveRefresh(view: UITableView) {
        
        isRefreshed.asDriver().drive(onNext: { (value) in
            switch value {
            case .failed(let message):
                view.asunempty?.allowShow = true
                view.asunempty?.titleString = message
                view.asunHead.endRefreshing()
                view.asunFoot.endRefreshing()
                MBProgressExtension.show(title: message)
            case .ok:
                view.asunempty?.allowShow = true
                view.asunHead.endRefreshing()
                view.asunFoot.endRefreshing()
            case .networkError(let message):
                view.asunempty?.allowShow = true
                view.asunempty?.titleString = message
                view.asunHead.endRefreshing()
                view.asunFoot.endRefreshing()
                MBProgressExtension.show(title: message)
            case .needRefresh:
                view.asunHead.beginRefreshing()
            case .noMoreData:
                view.asunempty?.allowShow = true
                view.asunHead.endRefreshing()
                view.asunFoot.endRefreshingWithNoMoreData()
            }
        }).disposed(by: bag)
    }
}
