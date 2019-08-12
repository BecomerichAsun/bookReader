//
//  LoginViewController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/11.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit
import RxSwift
import IQKeyboardManagerSwift
import TransitionButton

class LoginViewController: AsunBaseViewController {

    lazy var loginView: LoginView = LoginView.shared

    let bag = DisposeBag()

    var loginViewModel: LoginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configUI() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.keyboardDistanceFromTextField = screenHeight/2

        self.view.createBaseGradientLayer()
        self.view.blurView.setup(style: .light, alpha: 0.7).enable(isHidden: false)

        view.addSubview(loginView)
        loginView.snp.makeConstraints{
            $0.bottom.leading.trailing.equalToSuperview()
            $0.height.equalTo(screenHeight*0.5)
        }

        loginView.delegate = self
    }
}

extension LoginViewController: loginDelegate {
    func loginAction(action: TransitionButton, account: String, password: String) {
        loginViewModel.driverLoginAction(input: (username: account, password: password, view: view,btn: action), depency: bag)
    }

    func loginActionProtocl() {

    }

    func loginActioPrivacyAgreement() {

    }
}
