//
//  Gloabl.swift
//  ASUN-BOOM-EXTENSION
//
//  Created by Asun on 2019/3/26.
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

let staticResources:String = "http://statics.zhuishushenqi.com"

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

public func safeAreaTop() -> CGFloat {
    if #available(iOS 11.0, *) {
        //iOS 12.0以后的非刘海手机top为 20.0
        if (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.bottom == 0 {
            return 20.0
        }
        return (UIApplication.shared.delegate as? AppDelegate)?.window?.safeAreaInsets.top ?? 20.0
    }
    return 20.0
}

var isIphoneX: Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
        && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 812
            || max(UIScreen.main.bounds.height, UIScreen.main.bounds.width) == 896)
}

func pingFangSizeRegular(size:CGFloat) -> UIFont{
    return UIFont.init(name: "PingFangSC-Regular", size: size)!
}
func pingFangSizeMedium(size:CGFloat) -> UIFont{
    return UIFont.init(name: "PingFangSC-Medium", size: size)!
}
func pingFangSizeLight(size:CGFloat) -> UIFont{
    return UIFont.init(name: "PingFangSC-Light", size: size)!
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

    class var text: UIColor {
        return UIColor(r: 145, g: 144, b: 149)
    }

    class var theme: UIColor {
        return UIColor(r: 29, g: 221, b: 43)
    }
}

extension NSNotification.Name {
    static let USexTypeDidChange = NSNotification.Name("USexTypeDidChange")
    static let AsunNetworkListenName = NSNotification.Name("AsunNetworkListenName")
    static let AsunSelected = NSNotification.Name("AsunSelected")
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


func getSize<T>(content:T,font:UIFont) -> CGRect {
    return ("\(content)" as NSString).boundingRect(with: CGSize(width: 100, height: 100), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:font], context: nil)
}


