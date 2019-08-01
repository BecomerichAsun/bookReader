//
//  ReadTopView.swift
//  GoodBookRead
//
//  Created by Asun on 2019/4/1.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit

class ReadTopBar: UIView {

    lazy var backButton: UIButton = {
        let bn = UIButton(type: .custom)
        bn.setImage(UIImage(named: "nav_back_black"), for: .normal)
        return bn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configUI() {

        addSubview(backButton)

        backButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.left.centerY.equalToSuperview()
        }
    }
}
