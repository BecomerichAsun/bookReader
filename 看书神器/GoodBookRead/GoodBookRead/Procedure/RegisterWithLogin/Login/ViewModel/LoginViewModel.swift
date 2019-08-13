//
//  LoginViewModel.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/12.
//  Copyright © 2019 Asun. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import TransitionButton

class LoginViewModel: NSObject {

    lazy var dataSource: Observable<LoginModel> = Observable.from(optional: nil)
    
    lazy var username: BehaviorRelay<String> = BehaviorRelay(value: "")
    lazy var password: BehaviorRelay<String> = BehaviorRelay(value: "")
    lazy var valited: BehaviorRelay<Bool> = BehaviorRelay(value: false)
    

    func driverLoginAction(input: (username: String ,password: String ,view: UIView ,btn: TransitionButton), depency: DisposeBag) {
        username.accept(input.username)
        
        password.accept(input.password)
       
        username.subscribe(onNext: { [weak self] (value) in
            guard let `self` = self else { return }
            if !value.isEmpty && value.count == 11 {
                self.valited.accept(true)
            } else {
                input.btn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: {
                    Toast.show(view: input.view, tips: ResultTips.error.rawValue)})
            }
        }).disposed(by: depency)
        
        password.subscribe(onNext: { [weak self] (value) in
            guard let `self` = self else { return }
            if self.valited.value == true {
                if !value.isEmpty && value.count >= 8 {
                    self.dataSource = RequestService.requestLogin(username: input.username, password: input.password)
                } else {
                    input.btn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: {
                        Toast.show(view: input.view, tips: ResultTips.error.rawValue)
                    })
                }
            }
        }).disposed(by: depency)

        
        self.dataSource.subscribe(onNext: { (value) in
            if value.status == 1 && value.data?.status == 1{
                if let username = value.data?.userInfo?.userName {
                    let key = Key<String>(UserDefaultsKey.username.rawValue)
                    Defaults.shared.set(username, for: key)
                    Cookies.addUsernameCookie(cookie: username)
                }
                input.btn.stopAnimation(animationStyle: .expand, revertAfterDelay: 2.0) {
                    let window = UIWindow(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
                    window.makeKeyAndVisible()
                    let vc = AsunTabBarController()
                    window.rootViewController = vc
                }
            } else {
                input.btn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: {
                    Toast.show(view: input.view, tips: ResultTips.error.rawValue)
                    input.btn.cornerRadius = 25
                })
            }
        }, onError: { (error) in
            input.btn.stopAnimation(animationStyle: .shake, revertAfterDelay: 0.5, completion: {
                input.btn.cornerRadius = 25
                Toast.show(view: input.view, tips: ResultTips.error.rawValue)
            })
        }).disposed(by: depency)
    }

}

extension LoginViewModel {
    func configUI() {

    }
}
