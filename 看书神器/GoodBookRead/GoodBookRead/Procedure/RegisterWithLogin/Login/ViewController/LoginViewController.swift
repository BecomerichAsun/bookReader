//
//  LoginViewController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/11.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit

class LoginViewController: AsunBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    
    
    override func configUI() {
        self.view.createBaseGradientLayer()
        self.view.blurView.setup(style: .light, alpha: 0.4).enable(isHidden: false)
    }
}
