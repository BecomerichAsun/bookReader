//
//  RXbinderExtension.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/5.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MJRefresh
import Moya
import HandyJSON
import Alamofire

extension Reactive where Base: UIImageView {
    public var webImage: Binder<String?> {
        return Binder(self.base) { imageView, webUrl in
            imageView.yy_setImage(with: URL(string:webUrl ?? "") ?? URL(string:""), placeholder: UIImage.blankImage())
        }
    }
}


extension Reactive where Base: UIView {
    public var width: Binder<CGFloat?> {
        return Binder(self.base) { label, float in
            label.snp.updateConstraints{
                $0.width.equalTo(float ?? 0)
            }
        }
    }

    public var height: Binder<CGFloat?> {
        return Binder(self.base) { label, float in
            label.snp.updateConstraints{
                $0.height.equalTo(float ?? 0)
            }
        }
    }

    public var size: Binder<CGSize?> {
        return Binder(self.base) { label, size in
            label.snp.updateConstraints{
                $0.size.equalTo(size ?? CGSize(width: 0, height: 0))
            }
        }
    }
}

extension Reactive where Base: MJRefreshComponent {

    var refreshing: ControlEvent<Void> {
        let source: Observable<Void> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = {
                    observer.on(.next(()))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }

    var endRefreshing: Binder<Bool> {
        return Binder(base) { refresh, isEnd in
            if isEnd {
                refresh.endRefreshing()
            }
        }
    }
}

extension Reactive where Base: UITableView {
    var beginReloadData: Binder<Bool> {
        return Binder(base) { table , isBegin in
            if isBegin {
                table.reloadData()
            }
        }
    }
}

extension Reactive where Base: UICollectionView {
    var beginReloadData: Binder<Bool> {
        return Binder(base) { table , isBegin in
            if isBegin {
                table.reloadData()
            }
        }
    }
}

extension Reactive where Base: MoyaProviderType {
    @discardableResult
    func asunRequest<T: HandyJSON>(_ token: Base.Target
        , type:T.Type
        , callbackQueue: DispatchQueue? = nil, isCancel: Bool) -> Observable<T> {

        return Observable.create { [weak base]  ob in
            let cancellableToken = base?.request(token, callbackQueue: callbackQueue, progress: nil, completion: { result in
                switch result {
                case let .success(response):
                    do {
                        if token.method == .post {
                         let httpResponse = response.response?.allHeaderFields["Set-Cookie"]
                            UserDefaults.standard.set(httpResponse, forKey: "cookie")
                        }
                        
                        let json = try response.mapString()
                        AsunLog(json)
                        guard let model = JSONDeserializer<T>.deserializeFrom(json: json) else {
                            let error = NSError(domain: "解析错误", code: 999, userInfo: nil)
                          ob.onError(error)
                            return
                        }
                        ob.onNext(model)
                    }
                    catch let error{
                        ob.onError(error)
                    }
                case let .failure(error):
                    ob.onError(error)
                }
            })

            return Disposables.create {
                if isCancel {
                   cancellableToken?.cancel()
                }
            }
        }
    }
}

