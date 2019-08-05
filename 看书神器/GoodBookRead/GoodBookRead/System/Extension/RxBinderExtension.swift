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

