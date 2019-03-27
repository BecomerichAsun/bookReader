//
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//


import Foundation
import UIKit

public var asun_defultFixSpace: CGFloat = 0
public var asun_disableFixSpace: Bool = false

extension UINavigationController {
    
    private struct AssociatedKeys {
        static var tempDisableFixSpace: Void?
        static var tempBehavor: Void?
    }
    
    static let asun_initialize: Void = {
        DispatchQueue.once {
            
            swizzleMethod(UINavigationController.self,
                          originalSelector: #selector(UINavigationController.viewDidLoad),
                          swizzleSelector: #selector(UINavigationController.asun_viewDidLoad))
            
            swizzleMethod(UINavigationController.self,
                          originalSelector: #selector(UINavigationController.viewWillAppear(_:)),
                          swizzleSelector: #selector(UINavigationController.asun_viewWillAppear(_:)))
            
            swizzleMethod(UINavigationController.self,
                          originalSelector: #selector(UINavigationController.viewWillDisappear(_:)),
                          swizzleSelector: #selector(UINavigationController.asun_viewWillDisappear(_:)))
            
        }
    }()
    
    private var tempDisableFixSpace: Bool {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tempDisableFixSpace) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tempDisableFixSpace, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @available(iOS 11.0, *)
    private var tempBehavor: UIScrollView.ContentInsetAdjustmentBehavior {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.tempBehavor) as? UIScrollView.ContentInsetAdjustmentBehavior ?? .automatic
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.tempBehavor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @objc private func asun_viewDidLoad() {
        disableFixSpace(true, with: true)
        asun_viewDidLoad()
    }
    
    @objc private func asun_viewWillAppear(_ animated: Bool) {
        disableFixSpace(true, with: false)
        asun_viewWillAppear(animated)
    }
    
    @objc private func asun_viewWillDisappear(_ animated: Bool) {
        disableFixSpace(false, with: true)
        asun_viewWillDisappear(animated)
    }
    
    private func disableFixSpace(_ disable: Bool, with temp: Bool) {
        if self is UIImagePickerController {
            if disable {
                if temp { tempDisableFixSpace = asun_disableFixSpace }
                asun_disableFixSpace = true
                if #available(iOS 11.0, *) {
                    tempBehavor = UIScrollView.appearance().contentInsetAdjustmentBehavior
                    UIScrollView.appearance().contentInsetAdjustmentBehavior = .automatic
                }
            } else {
                asun_disableFixSpace = tempDisableFixSpace
                if #available(iOS 11.0, *) {
                    UIScrollView.appearance().contentInsetAdjustmentBehavior = tempBehavor
                }
            }
        }
    }
}


@available(iOS 11.0, *)
extension UINavigationBar {

    static let u_initialize: Void = {
        DispatchQueue.once {
            swizzleMethod(UINavigationBar.self,
                          originalSelector: #selector(UINavigationBar.layoutSubviews),
                          swizzleSelector: #selector(UINavigationBar.u_layoutSubviews))
            
        }
    }()
    
    @objc func u_layoutSubviews() {
        u_layoutSubviews()
        
        if !asun_disableFixSpace {
            layoutMargins = .zero
            let space = asun_defultFixSpace
            for view in subviews {
                if NSStringFromClass(view.classForCoder).contains("ContentView") {
                    view.layoutMargins = UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
                }
            }
        }
    }
}

extension UINavigationItem {
    
    private enum BarButtonItem: String {
        case left = "_leftBarButtonItem"
        case right = "_rightBarButtonItem"
    }
    
    open override func setValue(_ value: Any?, forKey key: String) {
        
        if #available(iOS 11.0, *) {
            super.setValue(value, forKey: key)
        } else {
            if !asun_disableFixSpace && (key == BarButtonItem.left.rawValue || key == BarButtonItem.right.rawValue) {
                guard let item = value as? UIBarButtonItem else {
                    super.setValue(value, forKey: key)
                    return
                }
                let space = UIBarButtonItem(barButtonSystemItem: .fixedSpace,
                                            target: nil,
                                            action: nil)
                space.width = asun_defultFixSpace - 16
                
                if key == BarButtonItem.left.rawValue {
                    leftBarButtonItems = [space, item]
                } else {
                    rightBarButtonItems = [space, item]
                }
            } else {
                super.setValue(value, forKey: key)
            }
        }
    }
}


