//
//  Gloabl.swift
//  ASUN-BOOM-EXTENSION
//
//  Created by Asun on 2019/1/17.
//  Copyright © 2019年 Asun. All rights reserved.
//

import Foundation
import UIKit
//import Kingfisher
import YYWebImage
import RxSwift
import RxCocoa
import NSObject_Rx
import SnapKit
import MJRefresh

/// 屏幕宽度
let screenWidth = UIScreen.main.bounds.width

/// 屏幕高度
let screenHeight = UIScreen.main.bounds.height

/// 获取当前的根控制器
var rootPresentedVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

/// Print
///
/// - Parameters:
///   - message: 输出内容
///   - file: 文件路径
///   - function: 方法名
///   - lineNumber: 行号
func AsunLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}

extension UIColor {
    class var background: UIColor {
        return UIColor(r: 242, g: 242, b: 242)
    }

    class var theme: UIColor {
        return UIColor(r: 29, g: 221, b: 43)
    }
}

extension NSNotification.Name {
    static let USexTypeDidChange = NSNotification.Name("USexTypeDidChange")
}

//MARK: SnapKit
extension ConstraintView {
    
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

extension UICollectionView {
    func reloadData(animation: Bool = true) {
        if animation {
            reloadData()
        } else {
            UIView .performWithoutAnimation {
                reloadData()
            }
        }
    }
}


extension Reactive where Base: UIImageView {
    public var webImage: Binder<String?> {
        return Binder(self.base) { imageView, webUrl in
            imageView.yy_setImage(with: URL(string:webUrl ?? "") ?? URL(string:""))
        }
    }
}

//extension KingfisherWrapper where Base: ImageView  {
//    @discardableResult
//    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "nav_bg")) -> DownloadTask {
//        return setImage(urlString: urlString ?? "", placeholder: placeholder)
//    }
//}

//extension KingfisherWrapper where Base: UIButton {
//    @discardableResult
//    public func setImage(urlString: String?, for state: UIControl.State, placeholder: UIImage? = UIImage(named: "normal_placeholder_h")) -> DownloadTask {
//        return setImage(urlString: urlString ?? "", for: state, placeholder: placeholder)
//    }
//}

//MARK: swizzledMethod
extension NSObject {
    
    static func swizzleMethod(_ cls: AnyClass, originalSelector: Selector, swizzleSelector: Selector){
        
        let originalMethod = class_getInstanceMethod(cls, originalSelector)!
        let swizzledMethod = class_getInstanceMethod(cls, swizzleSelector)!
        let didAddMethod = class_addMethod(cls,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        if didAddMethod {
            class_replaceMethod(cls,
                                swizzleSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
}


