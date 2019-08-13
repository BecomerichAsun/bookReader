//
//  LoginView.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/12.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import YYText
import TransitionButton


protocol loginDelegate: class {
    func loginAction(action: TransitionButton, account: String , password: String)
    func loginActionProtocl()
    func loginActioPrivacyAgreement()
}

class LoginView: UIView {
    
    static let shared = LoginView()
    
    weak var delegate: loginDelegate?
    
    lazy var accountTextView: AsunTextView = {
        let text = AsunTextView()
        text.backgroundColor = UIColor.whiteColor.withAlphaComponent(0.3)
        text.delegate = self
        text.becomeFirstResponder()
        text.frame = CGRect(x: screenWidth*0.1, y: 0, width: screenWidth*0.8, height: 50)
        text.isScrollEnabled = false
        text.keyboardType = UIKeyboardType.asciiCapableNumberPad
        text.returnKeyType = UIReturnKeyType.continue
        text.textColor = UIColor.whiteColor.withAlphaComponent(0.8)
        text.font = pingFangSizeMedium(size: 18)
        text.textAlignment = .left
        text.tintColor = UIColor.whiteColor
        return text
    }()
    
    lazy var passWordTextView: AsunTextView = {
        let text = AsunTextView()
        text.backgroundColor = UIColor.whiteColor.withAlphaComponent(0.3)
        text.isSecureTextEntry = true
        text.delegate = self
        text.accountLabel.isHidden = true
        text.frame = CGRect(x: screenWidth*0.1, y: 58, width: screenWidth*0.8, height: 50)
        text.keyboardType = UIKeyboardType.default
        text.returnKeyType = UIReturnKeyType.done
        text.textColor = UIColor.whiteColor.withAlphaComponent(0.8)
        text.font = pingFangSizeMedium(size: 18)
        text.textAlignment = .left
        text.changePlaceholder(text: "输入账号密码")
        text.tintColor = UIColor.whiteColor
        text.isSecureTextEntry = true
        return text
    }()
    
    lazy var findPwButton: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.hex(hexString: "#F7AE5D"), for: .normal)
        btn.setTitleColor(UIColor.hex(hexString: ("#F7AE5D")), for: .highlighted)
        btn.titleLabel?.font = pingFangSizeMedium(size: 15)
        btn.setTitle("忘记了? 找回密码", for: .normal)
        return btn
    }()
    
    lazy var loginButton: TransitionButton = {
        let btn = TransitionButton()
        btn.backgroundColor = UIColor.whiteColor.withAlphaComponent(0.3)
        btn.setTitleColor(UIColor.whiteColor, for: .normal)
        btn.titleLabel?.font = pingFangSizeMedium(size: 15)
        btn.setTitle("开始好好读书", for: .normal)
        return btn
    }()

    lazy var extensionLabel: YYLabel = {
        let la = YYLabel()
        return la
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addConstraints() {
        self.backgroundColor = UIColor.clear
        addSubview(accountTextView)
        addSubview(passWordTextView)
        addSubview(findPwButton)
        findPwButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(passWordTextView.snp.bottom).offset(20)
        }

        addSubview(loginButton)
        loginButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-35)
            $0.size.equalTo(CGSize(width: screenWidth*0.8, height: 50))
        }

        addSubview(extensionLabel)
        extensionLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.lessThanOrEqualTo(screenWidth * 0.8)
            $0.bottom.equalTo(loginButton.snp.top).offset(-15)
        }

        let text = NSMutableAttributedString(string: "登录即表明同意 用户协议 和 隐私政策")
        text.yy_font = pingFangSizeMedium(size: 15)
        text.yy_color = UIColor.whiteColor.withAlphaComponent(0.5)
        text.yy_lineSpacing = 5
        text.yy_alignment = .center

        text.yy_setTextHighlight(NSMakeRange(15, 4), color: UIColor.hex(hexString: "#F7AE5D"), backgroundColor: nil) { [weak self] (view, str, range, rect) in
            guard let `self` = self else { return }
            if let del = self.delegate {
                del.loginActioPrivacyAgreement()
            }
        }

        text.yy_setTextHighlight(NSMakeRange(8, 5), color: UIColor.hex(hexString: "#F7AE5D"), backgroundColor: nil) { [weak self] (view, str, range, rect) in
            guard let `self` = self else { return }
            if let del = self.delegate {
                del.loginActionProtocl()
            }
        }

        self.extensionLabel.attributedText = text

        loginButton.rx.tap.subscribe(onNext: { [weak self] (_) in
            guard let `self` = self else { return }
            self.loginButton.startAnimation()
            if let del = self.delegate {
                del.loginAction(action: self.loginButton, account: self.accountTextView.text , password: self.passWordTextView.text)
            }
        }).disposed(by: rx.disposeBag)
    }
}

extension LoginView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == accountTextView {
            if textView.text.count > 0 {
                accountTextView.changePlaceholder(text: "")
            } else {
                accountTextView.changePlaceholder(text: "输入手机号码")
            }
        } else {
            if textView.text.count > 0 {
                passWordTextView.changePlaceholder(text: "")
            } else {
                passWordTextView.changePlaceholder(text: "输入账号密码")
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text.isEmpty {
            return true
        }
        
        let tf = textView as! AsunTextView
        
        if tf == accountTextView {
            if let text = tf.text {
                if text.count >= 11 {
                    return false
                }
            }
        } else if tf == passWordTextView {
            if text.elementsEqual("\n") {
                passWordTextView.resignFirstResponder()
                return false
            }
            if let text = tf.text {
                if text.count >= 16 {
                    return false
                }
            }
        }
        return true
    }
}
