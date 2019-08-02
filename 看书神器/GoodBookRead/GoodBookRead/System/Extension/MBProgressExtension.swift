//
//  MBProgressExtension.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/2.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import MBProgressHUD

struct MBProgressExtension {

    static let KeyWindow: UIWindow = UIApplication.shared.keyWindow ?? UIWindow()

    static func show(addKeyWindowAnimated animated: Bool? = true, title: String? = "") {
        for view in KeyWindow.subviews {
            if view.isKind(of: MBProgressHUD.self) {
                view.removeFromSuperview()
                break
            }
        }
        let hud = MBProgressHUD.showAdded(to: KeyWindow, animated: animated!)
        hud.mode = .text
        hud.label.text = title!
        hud.hide(animated: true, afterDelay: 2.5)
    }
}
