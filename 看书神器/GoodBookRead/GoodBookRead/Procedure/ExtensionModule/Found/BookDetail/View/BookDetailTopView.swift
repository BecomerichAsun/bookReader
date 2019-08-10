//
//  DetailTopView.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/10.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit
import Then

class BookDetailTopView: UIView {
    
    static let asunCreat = BookDetailTopView.init(frame: CGRect.zero)

    let bookBackGroundImageView = UIImageView()

    let label = UILabel().then {
        $0.textAlignment = .left
        $0.font = pingFangSizeRegular(size: 17)
        $0.textColor = UIColor.white
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      addConstraint()
        driver()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addConstraint() {
        addSubview(bookBackGroundImageView)
        bookBackGroundImageView.snp.makeConstraints{
            $0.size.equalTo(CGSize(width: screenWidth, height: 225))
            $0.top.leading.trailing.equalToSuperview()
        }
    }
}

extension BookDetailTopView {
    
    func driver() {
        self.bookBackGroundImageView.image = UIImage(named: "k4sTS3n-XqY")
         self.bookBackGroundImageView.blurView.setup(style: .dark, alpha: 0.6).enable(isHidden: false)
//        bookBackGroundImageView.image?.Asun_cornetImage(size:CGSize(width: 5, height: 5) , completion: { [weak self] (image) in
//            guard let `self` = self else { return }
//            self.bookBackGroundImageView.blurView.setup(style: .light, alpha: 0.5).enable(isHidden: false)
////            self.bookBackGroundImageView.AsunSetImage(imageName: "refresh_discover", placeholder: UIImage.blankImage())
//            self.bookBackGroundImageView.image = UIImage(named: "refresh_discover")
//            self.bookBackGroundImageView.image = image
//        })
    }
}


