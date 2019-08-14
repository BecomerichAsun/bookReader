//
//  BookDetailTableViewCell.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/29.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit

class BookDetailTableViewCell: AsunBaseTableViewCell {
    
    lazy var bookView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        contentView.addSubview(iw)
        return iw
    }()
    
    lazy var bookNameLabel: UILabel = {
        let nl = UILabel()
        nl.textColor = UIColor.black
        nl.textAlignment = .left
        nl.asunMargin.changeLabelRowSpace(lineSpace: 0, wordSpace: 0.5)
        nl.numberOfLines = 1
        nl.font = pingFangSizeMedium(size: 15)
        contentView.addSubview(nl)
        return nl
    }()
    
    lazy var bookAuthorLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 1
        nl.textAlignment = .left
        nl.textColor = UIColor.text
        nl.font = pingFangSizeLight(size: 12)
        nl.asunMargin.changeLabelRowSpace(lineSpace: 0, wordSpace: 0.3)
        contentView.addSubview(nl)
        return nl
    }()
    
    lazy var dividerView: UIView = {
        let uv = UIView()
        uv.backgroundColor = UIColor.text.withAlphaComponent(0.6)
        contentView.addSubview(uv)
        return uv
    }()
    
    lazy var bookExtensionLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 1
        nl.textAlignment = .left
        nl.textColor = UIColor.text
        nl.font = pingFangSizeLight(size: 12)
        nl.asunMargin.changeLabelRowSpace(lineSpace: 0, wordSpace: 0.3)
        contentView.addSubview(nl)
        return nl
    }()
    
    lazy var bookDetailLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 2
        nl.textAlignment = .left
        nl.textColor = UIColor(r: 137, g: 137, b: 145)
        nl.font = pingFangSizeLight(size: 12)
        nl.asunMargin.changeLabelRowSpace(lineSpace: 0.3, wordSpace: 0.2)
        contentView.addSubview(nl)
        return nl
    }()

    lazy var bookPeopleView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage.blankImage()
        iw.backgroundColor = UIColor(r: 241, g: 242, b: 245)
        iw.layer.cornerRadius = 10
        iw.clipsToBounds = true
        iw.contentMode = .scaleAspectFill
        contentView.addSubview(iw)
        return iw
    }()
    
    lazy var bookPeopleIconView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage(named: "hot")
        iw.contentMode = .scaleAspectFill
        contentView.addSubview(iw)
        return iw
    }()
    
    lazy var bookCountLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 1
        nl.textAlignment = .left
        nl.textColor = UIColor.gray
        nl.font = pingFangSizeLight(size: 10)
        contentView.addSubview(nl)
        return nl
    }()
    
    override func configUI() {
        bookView.snp.makeConstraints{
            $0.left.top.equalToSuperview().offset(10)
            $0.size.equalTo(CGSize(width: 70, height: 100))
        }

        bookView.layer.shadowColor = UIColor.gray.cgColor
        bookView.layer.shadowOffset = CGSize(width: 3, height: 0)
        bookView.layer.shadowOpacity = 0.8

        bookPeopleView.snp.makeConstraints{
            $0.top.equalTo(bookView)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
            $0.width.equalTo(45)
        }

        bookPeopleIconView.snp.makeConstraints{
            $0.leading.equalTo(bookPeopleView).offset(5)
            $0.centerY.equalTo(bookPeopleView)
            $0.size.equalTo(CGSize(width: 12, height: 12))
        }

        bookCountLabel.snp.makeConstraints{
            $0.leading.equalTo(bookPeopleIconView.snp.trailing).offset(3)
            $0.centerY.equalTo(bookPeopleView)
            $0.trailing.equalTo(bookPeopleView).offset(-5)
        }

        bookNameLabel.snp.makeConstraints{
            $0.top.equalTo(bookView).offset(4)
            $0.leading.equalTo(bookView.snp.trailing).offset(15)
            $0.trailing.equalTo(bookPeopleView.snp.leading).offset(10)
            $0.height.equalTo(20)
        }

        bookAuthorLabel.snp.makeConstraints{
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(bookNameLabel.snp.leading)
            $0.size.equalTo(CGSize(width: 10, height: 10))
        }

        dividerView.snp.makeConstraints{
            $0.top.equalTo(bookAuthorLabel).offset(3)
            $0.bottom.equalTo(bookAuthorLabel).offset(-3)
            $0.leading.equalTo(bookAuthorLabel.snp.trailing).offset(4)
            $0.width.equalTo(0.8)
        }

        bookExtensionLabel.snp.makeConstraints{
            $0.top.equalTo(bookAuthorLabel)
            $0.leading.equalTo(dividerView.snp.trailing).offset(4)
            $0.bottom.equalTo(bookAuthorLabel)
            $0.trailing.equalToSuperview().offset(-15)
        }

        bookDetailLabel.snp.makeConstraints{
            $0.top.equalTo(bookAuthorLabel.snp.bottom).offset(2)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-15)
            $0.bottom.equalTo(bookView).offset(-4)
            $0.leading.equalTo(bookAuthorLabel.snp.leading)
        }
    }

}


