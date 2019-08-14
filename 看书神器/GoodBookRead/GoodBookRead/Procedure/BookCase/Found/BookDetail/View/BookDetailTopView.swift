//
//  DetailTopView.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/10.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit

class BookDetailTopView: UIView {
    
    static let asunCreat = BookDetailTopView.init(frame: CGRect.zero)

    let bookBackGroundImageView = UIImageView().then { (image) in
        image.contentMode = .scaleAspectFill
        image.backgroundColor = UIColor.blackColor
    }

    let nameLabel = UILabel().then {
        $0.text = "元尊"
        $0.textAlignment = .left
        $0.font = xingkaiSize(size: 28)
        $0.textColor = UIColor.white
    }
    
    let bookTitleImageView = UIImageView().then { (image) in
        image.layer.cornerRadius = 10.0
        image.layer.masksToBounds = true
        image.layer.borderWidth = 2.5
        image.layer.borderColor = UIColor.whiteColor.cgColor
        image.contentMode = .scaleAspectFill
        image.layer.rasterizationScale = UIScreen.main.scale
        image.layer.shouldRasterize = true
    }
    
    let authorLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = pingFangSizeRegular(size: 17)
        $0.textColor = UIColor.white
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         addConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addConstraint() {
        bookBackGroundImageView.blurView.setup(style: .light, alpha: 1).enable(isHidden: false)
        addSubview(bookBackGroundImageView)
        bookBackGroundImageView.snp.makeConstraints{
            $0.size.equalTo(CGSize(width: screenWidth, height: screenHeight/3.8))
            $0.top.leading.trailing.equalToSuperview()
        }
        
        addSubview(bookTitleImageView)
        bookTitleImageView.snp.makeConstraints{
            $0.leading.equalTo(20)
            $0.top.equalTo(NavBarHeight + 15)
            $0.size.equalTo(CGSize(width: screenWidth/3.3, height: screenHeight/4.5))
        }
        
        addSubview(nameLabel)
        nameLabel.snp.makeConstraints{
            $0.leading.equalTo(bookTitleImageView.snp.trailing).offset(20)
            $0.top.equalTo(bookTitleImageView)
            $0.width.lessThanOrEqualTo(screenWidth - screenWidth/3 - 40)
        }
    }
}

extension BookDetailTopView {

}


