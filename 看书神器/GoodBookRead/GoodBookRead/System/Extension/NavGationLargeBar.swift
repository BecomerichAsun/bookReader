//
//  NavGationLargeBar.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/10.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit


class NavGationLargeBar: UIView {
    
    var largeText: String?

    init(text: String) {
        super.init(frame: CGRect.zero)
        self.largeText = text
        self.backgroundColor = UIColor.blackColor
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        if let text = self.largeText {
           text.draw(at: CGPoint(x: 20, y: 20), withAttributes: [NSAttributedString.Key.font :
            xingkaiSize(size: 35),NSAttributedString.Key.foregroundColor : UIColor.whiteColor])
        }
    }
}
