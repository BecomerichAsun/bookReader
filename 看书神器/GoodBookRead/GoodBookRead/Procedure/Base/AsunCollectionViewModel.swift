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
import NSObject_Rx
import Then

/// 下拉刷新状态
///
/// - ok: 完成
/// - networkError: 网络错误
/// - failed: 服务器请求错误
/// - needRefresh: 外部调用刷新
enum RefreshMode {
    case ok
    case networkError(message: String)
    case failed(message: String)
    case needRefresh
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
        case .needRefresh:
            return ""
        }
    }
}

/// Action协议
protocol ActionExtensionProtocol: class {
    func didSelected(data: ExtensionCellViewModel, extensionName: String)
    func didSelected(data: Any)
}

extension ActionExtensionProtocol {
    func didSelected(data: ExtensionCellViewModel, extensionName: String) {AsunLog("===DidSelected===")}
    func didSelected(data: Any) {AsunLog("DidSelected No Data")}
}

@objcMembers class AsunCollectionViewModel: NSObject, ActionExtensionProtocol {

    /// Push等操作闭包别名
    typealias action = ()->()
    
    let bag = DisposeBag()
    
    lazy var isRefreshed: BehaviorRelay<RefreshMode> = BehaviorRelay(value: RefreshMode.ok)

    weak var deleagte: ActionExtensionProtocol?

    func driverViewModel(view: UICollectionView, refresh: [String : Bool]? = ["HeaderRefresh" : true, "FooterRefresh" : true], actionProtocol : ActionExtensionProtocol, actionCallBack: action) {
        driverData(with: view, refresh: refresh, actionProtocol: actionProtocol, actionCallBack: actionCallBack)
    }
}

extension AsunCollectionViewModel {

    /// 设置控件基本属性 创建订阅 初始化等
    ///
    /// - Parameters:
    ///   - view: 操作的View
    ///   - refresh: 是否需要刷新控件 HeaderRefresh 头部 FooterRefresh 尾部 默认含有无数据页面
    ///   - actionProtocol: 跳转代理
    ///   - actionCallBack: 继承后续操作闭包回调
    private func driverData(with view: UICollectionView, refresh: [String : Bool]? = ["HeaderRefresh" : true, "FooterRefresh" : true], actionProtocol : ActionExtensionProtocol , actionCallBack: action) {

        configCollectionView(view: view)

        self.deleagte = actionProtocol

        if refresh!.keys.contains("HeaderRefresh") {
            ifNeedRefresh(header: refresh!["HeaderRefresh"]!, footer: false, view: view)
        } else  if refresh!.keys.contains("FooterRefresh") {
            ifNeedRefresh(header: false, footer: refresh!["FooterRefresh"]!, view: view)
        } else if refresh!.keys.contains("FooterRefresh") && refresh!.keys.contains("HeaderRefresh") {
            ifNeedRefresh(header: refresh!["HeaderRefresh"]!, footer: refresh!["FooterRefresh"]!, view: view)
        }

        driveRefresh(view: view)

        actionCallBack()

        requestList()
    }

    /// 请求
    func requestList() { }

    /// 设置基本属性
    func configCollectionView(view: UICollectionView) { }

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
    private func ifNeedRefresh(header: Bool, footer: Bool, view: UICollectionView) {
        if header {
            view.asunHead = AsunRefreshHeader { [weak self] in
                guard let `self` = self else { return }
                self.requestList()
            }
        }
        view.asunempty = AsunEmptyView {[weak self] in
            guard let `self` = self else { return }
            self.requestList()
        }
        if footer {
            view.asunFoot = AsunRefreshDiscoverFooter()
        }
    }

    /// 订阅刷新控件状态
    private func driveRefresh(view: UICollectionView) {

        isRefreshed.asDriver().drive(onNext: { (value) in
            switch value {
            case .failed(let message):
                view.asunempty?.allowShow = true
                view.asunempty?.titleString = message
                view.asunHead.endRefreshing()
                MBProgressExtension.show(title: message)
            case .ok:
                view.asunempty?.allowShow = true
                view.asunHead.endRefreshing()
                view.reloadData(animation: true)
            case .networkError(let message):
                view.asunempty?.allowShow = true
                view.asunempty?.titleString = message
                view.asunHead.endRefreshing()
                MBProgressExtension.show(title: message)
            case .needRefresh:
                view.asunHead.beginRefreshing()
            }
        }).disposed(by: bag)
    }
}
