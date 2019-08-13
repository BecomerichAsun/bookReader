//
//  AsunTextView.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/12.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit

class AsunTextView: UITextView {

    lazy var placeholder: String = "输入手机号码"

    lazy var accountLabel:UILabel = {
        let la = UILabel()
        la.text = "+86"
        la.font = pingFangSizeMedium(size: 18)
        la.textColor = UIColor.whiteColor
        return la
    }()

    var originalRect: CGRect?

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        self.addSubview(accountLabel)
        accountLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(10)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        if self.hasText {return}
        let lineSpace = NSMutableParagraphStyle()
        lineSpace.lineSpacing = 4

        var attrs = [NSAttributedString.Key: Any]()
        attrs[NSAttributedString.Key.font] = self.font!

        attrs[NSAttributedString.Key.foregroundColor] = UIColor.whiteColor.withAlphaComponent(0.5)
        attrs[NSAttributedString.Key.paragraphStyle] = lineSpace

        var oriRect = rect

        oriRect.origin.y = (50 - (self.font?.lineHeight ?? 5))/2
        if accountLabel.isHidden {
            oriRect.origin.x = 15
            self.isSecureTextEntry = true
            changgeTextViewInsert(insets: UIEdgeInsets(top: (50 - (self.font?.lineHeight ?? 5))/2, left: 10, bottom: 0, right: 0))
            (self.placeholder as NSString).draw(in: oriRect, withAttributes: attrs)
        } else {
            oriRect.origin.x = accountLabel.frame.origin.x + accountLabel.frame.size.width + 15

            changgeTextViewInsert(insets: UIEdgeInsets(top: (50 - (self.font?.lineHeight ?? 5))/2, left: accountLabel.frame.origin.x + accountLabel.frame.size.width + 10, bottom: 0, right: 0))
              (self.placeholder as NSString).draw(in: oriRect, withAttributes: attrs)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
    }

    // 设置光标位置
    override func caretRect(for position: UITextPosition) -> CGRect {
        var originalRect = super.caretRect(for: position)
        originalRect.size.height = (self.font?.lineHeight ?? 5) + 2
        originalRect.size.width = 3
        originalRect.origin.y = (50 - (self.font?.lineHeight ?? 5))/2
        return originalRect
    }

    func changePlaceholder(text: String) {
        self.placeholder = text
        self.setNeedsDisplay()
    }

    func changgeTitle(text: String) {
        self.accountLabel.text = text
    }

    func changgeTextViewInsert(insets: UIEdgeInsets) {
        self.textContainerInset = insets
    }
}
