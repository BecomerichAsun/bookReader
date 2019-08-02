//
//  ViewModelExtension.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/2.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation

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

/// Action控制器交互协议
protocol ActionExtensionProtocol: class {
    func didSelected(data: ExtensionCellViewModel, extensionName: String)
    func didSelected(data: Any)
}

extension ActionExtensionProtocol {
    func didSelected(data: ExtensionCellViewModel, extensionName: String) {AsunLog("===DidSelected===")}
    func didSelected(data: Any) {AsunLog("DidSelected No Data")}
}
