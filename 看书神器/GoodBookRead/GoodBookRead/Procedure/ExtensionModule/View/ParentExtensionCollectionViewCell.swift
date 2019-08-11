//
//  ParentExtensionCollectionViewCell.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit
import HandyJSON
import YYWebImage
import Reusable

class ParentExtensionCollectionViewCell: AsunBaseCollectionViewCell {

    lazy var extensionImageView: UIImageView = {
        let iw = UIImageView()
        iw.layer.cornerRadius = 5
        iw.clipsToBounds = true
        iw.contentMode = .scaleAspectFill
        contentView.addSubview(iw)
        return iw
    }()

    lazy var extensionTitleLabel: UILabel = {
        let tl = UILabel()
        tl.font = pingFangSizeRegular(size: 14)
        tl.textAlignment = .center
        tl.textColor = .black
        tl.lineBreakMode = .byCharWrapping
        contentView.addSubview(tl)
        return tl
    }()
    
    override func configUI() {
        extensionTitleLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.contentView.usnp.bottom)
        }
        extensionImageView.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(contentView.snp.height).multipliedBy(0.87)
        }
    }
}


/// -- Header
class ExtensionHeaderView:AsunBaseCollectionReusableView {
    private lazy var extensionImageView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        addSubview(iw)
        return iw
    }()

    private lazy var extensionHeaderLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.font = pingFangSizeMedium(size: 14)
        tl.textColor = UIColor(r: 220, g: 104, b: 10).withAlphaComponent(0.8)
        addSubview(tl)
        return tl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }


    override func configUI() {
        self.backgroundColor = UIColor.background
        extensionImageView.snp.makeConstraints{
            $0.leading.equalTo(self.usnp.leading).offset(10)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(CGSize(width: 24, height: 24))
        }
        extensionHeaderLabel.snp.makeConstraints{
            $0.leading.equalTo(extensionImageView.usnp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
    }

    func setHeaderProprety(_ title:String,imgName:String) {
        extensionHeaderLabel.text = title
        extensionImageView.image = UIImage(named: imgName)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


