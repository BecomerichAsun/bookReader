//
//  BookCaseTableViewCell.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/14.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit
import YYText

class BookCaseTableViewCell: AsunBaseTableViewCell {

    lazy var contentBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.whiteColor
        view.isOpaque = false
        contentView.addSubview(view)
        return view
    }()

    lazy var gradientView = GradientView()

    lazy var bookView: UIImageView = {
        let iw = UIImageView()
        contentView.addSubview(iw)
        return iw
    }()

    lazy var bookNameLabel: UILabel = {
        let nl = UILabel()
        nl.textColor = UIColor.boardText
        nl.textAlignment = .left
        nl.numberOfLines = 1
        nl.font = pingFangSizeMedium(size: 15)
        return nl
    }()

    lazy var bookAuthorLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 1
        nl.textAlignment = .left
        nl.textColor = UIColor.boardText
        nl.font = pingFangSizeLight(size: 11)
        return nl
    }()

    lazy var bookUpdateTextLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 1
        nl.textAlignment = .left
        nl.textColor = UIColor.text
        nl.font = pingFangSizeRegular(size: 11)
        contentView.addSubview(nl)
        return nl
    }()

    lazy var bookupdateView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage(named: "updateTime")
        iw.contentMode = .scaleAspectFill
        contentView.addSubview(iw)
        return iw
    }()

    lazy var bookUpdateTimeLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 1
        nl.textAlignment = .left
        nl.textColor = UIColor.text
        nl.font = pingFangSizeRegular(size: 11)
        contentView.addSubview(nl)
        return nl
    }()

    lazy var bookUpdateLabel: UILabel = {
        let nl = UILabel()
        nl.text = "更新"
        nl.numberOfLines = 1
        nl.textAlignment = .center
        nl.textColor = UIColor.whiteColor
        nl.font = pingFangSizeMedium(size: 11)
        contentView.addSubview(nl)
        return nl
    }()

    override func configUI() {
        self.contentView.backgroundColor = UIColor.background
        self.contentView.isOpaque = false

        contentBackgroundView.snp.makeConstraints{
            $0.top.equalTo(30)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(screenWidth*0.9)
            $0.bottom.equalToSuperview().offset(-5)
        }

        contentBackgroundView.layer.cornerRadius = 10
        contentBackgroundView.layer.shadowColor = UIColor.gray.cgColor
        contentBackgroundView.layer.shadowOffset = CGSize(width: -0.2, height: -1.5)
        contentBackgroundView.layer.shadowOpacity = 0.1

        bookView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(contentBackgroundView).offset(10)
            $0.width.equalTo(80)
            $0.bottom.equalTo(contentBackgroundView.snp.bottom).offset(-10)
        }

        bookView.layer.cornerRadius = 10
        bookView.clipsToBounds = true
        bookView.layer.shadowColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        bookView.layer.shadowOffset = CGSize(width: 0, height: -0.5)
        bookView.layer.shadowOpacity = 0.15

        contentBackgroundView.addSubview(bookNameLabel)
        bookNameLabel.snp.makeConstraints{
            $0.top.equalTo(contentBackgroundView).offset(17)
            $0.leading.equalTo(105)
            $0.height.equalTo(20)
            $0.width.lessThanOrEqualTo(screenWidth*0.5)
        }

        contentBackgroundView.addSubview(bookAuthorLabel)
        bookAuthorLabel.snp.makeConstraints{
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(bookNameLabel.snp.leading)
            $0.height.equalTo(10)
            $0.width.lessThanOrEqualTo(screenWidth*0.5)
        }
        contentBackgroundView.addSubview(bookUpdateTextLabel)
        bookUpdateTextLabel.snp.makeConstraints{
            $0.top.equalTo(bookAuthorLabel.snp.bottom).offset(8)
            $0.leading.equalTo(bookAuthorLabel.snp.leading)
            $0.width.lessThanOrEqualTo(screenWidth*0.5)
            $0.height.equalTo(20)
        }

        contentBackgroundView.addSubview(bookupdateView)
        bookupdateView.snp.makeConstraints{
            $0.top.equalTo(bookUpdateTextLabel.snp.bottom).offset(3)
            $0.leading.equalTo(bookUpdateTextLabel.snp.leading)
            $0.size.equalTo(CGSize(width: 16, height: 16))
        }

        contentBackgroundView.addSubview(bookUpdateTimeLabel)
        bookUpdateTimeLabel.snp.makeConstraints{
            $0.centerY.equalTo(bookupdateView)
            $0.leading.equalTo(bookupdateView.snp.trailing).offset(5)
            $0.width.lessThanOrEqualTo(screenWidth*0.5)
            $0.height.equalTo(20)
        }

        gradientView.frame = CGRect(x:screenWidth*0.90 - 30 , y: 0, width: 30, height: 30)
        contentBackgroundView.addSubview(gradientView)
        gradientView.createPointGradientLayer()
        gradientView.corner(byRoundingCorners: [.bottomLeft,.topRight], radii: 10)

        gradientView.addSubview(bookUpdateLabel)
        bookUpdateLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
}
