//
//  BookDetailTableViewCell.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/29.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit

class BookDetailTableViewCell: AsunBaseTableViewCell {

    private lazy var bookView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        return iw
    }()

    private lazy var bookNameLabel: UILabel = {
        let nl = UILabel()
        nl.textColor = UIColor.black
        nl.textAlignment = .left
        nl.asunMargin.changeLabelRowSpace(lineSpace: 0, wordSpace: 0.5)
        nl.numberOfLines = 1
        nl.font = pingFangSizeMedium(size: 15)
        return nl
    }()

    private lazy var bookAuthorLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 1
        nl.textAlignment = .left
        nl.textColor = UIColor.text
        nl.font = pingFangSizeLight(size: 12)
        nl.asunMargin.changeLabelRowSpace(lineSpace: 0, wordSpace: 0.3)
        return nl
    }()

    private lazy var dividerView: UIView = {
        let uv = UIView()
        uv.backgroundColor = UIColor.text.withAlphaComponent(0.6)
        return uv
    }()

    private lazy var bookExtensionLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 1
        nl.textAlignment = .left
        nl.textColor = UIColor.text
        nl.font = pingFangSizeLight(size: 12)
        nl.asunMargin.changeLabelRowSpace(lineSpace: 0, wordSpace: 0.3)
        return nl
    }()

    private lazy var bookDetailLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 2
        nl.textAlignment = .left
        nl.textColor = UIColor(r: 137, g: 137, b: 145)
        nl.font = pingFangSizeLight(size: 10)
        nl.asunMargin.changeLabelRowSpace(lineSpace: 0.3, wordSpace: 0.2)
        return nl
    }()


    private lazy var bookPeopleView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage.blankImage()
        iw.backgroundColor = UIColor(r: 241, g: 242, b: 245)
        iw.layer.cornerRadius = 10
        iw.clipsToBounds = true
        iw.contentMode = .scaleAspectFill
        return iw
    }()

    private lazy var bookPeopleIconView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage(named: "hot")
        iw.contentMode = .scaleAspectFill
        return iw
    }()

    private lazy var bookCountLabel: UILabel = {
        let nl = UILabel()
        nl.numberOfLines = 1
        nl.textAlignment = .left
        nl.textColor = UIColor.gray
        nl.font = pingFangSizeLight(size: 10)
        return nl
    }()

    override func configUI() {
        contentView.addSubview(bookView)
        bookView.snp.makeConstraints{
            $0.left.top.equalToSuperview().offset(10)
            $0.size.equalTo(CGSize(width: 70, height: 100))
        }

        contentView.addSubview(bookPeopleView)
        bookPeopleView.snp.makeConstraints{
            $0.top.equalTo(bookView)
            $0.trailing.equalToSuperview().offset(-10)
            $0.height.equalTo(20)
            $0.width.equalTo(45)
        }

        contentView.addSubview(bookPeopleIconView)
        bookPeopleIconView.snp.makeConstraints{
            $0.leading.equalTo(bookPeopleView).offset(5)
            $0.centerY.equalTo(bookPeopleView)
            $0.size.equalTo(CGSize(width: 12, height: 12))
        }

        contentView.addSubview(bookCountLabel)
        bookCountLabel.snp.makeConstraints{
            $0.leading.equalTo(bookPeopleIconView.snp.trailing).offset(3)
            $0.centerY.equalTo(bookPeopleView)
            $0.trailing.equalTo(bookPeopleView).offset(-5)
        }

        contentView.addSubview(bookNameLabel)
        bookNameLabel.snp.makeConstraints{
            $0.top.equalTo(bookView).offset(4)
            $0.leading.equalTo(bookView.snp.trailing).offset(15)
            $0.trailing.equalTo(bookPeopleView.snp.leading).offset(10)
            $0.height.equalTo(20)
        }

        contentView.addSubview(bookAuthorLabel)
        bookAuthorLabel.snp.makeConstraints{
            $0.top.equalTo(bookNameLabel.snp.bottom).offset(5)
            $0.leading.equalTo(bookNameLabel.snp.leading)
            $0.size.equalTo(CGSize(width: 10, height: 10))
        }

        contentView.addSubview(dividerView)
        dividerView.snp.makeConstraints{
            $0.top.equalTo(bookAuthorLabel).offset(3)
            $0.bottom.equalTo(bookAuthorLabel).offset(-3)
            $0.leading.equalTo(bookAuthorLabel.snp.trailing).offset(4)
            $0.width.equalTo(0.8)
        }

        contentView.addSubview(bookExtensionLabel)
        bookExtensionLabel.snp.makeConstraints{
            $0.top.equalTo(bookAuthorLabel)
            $0.leading.equalTo(dividerView.snp.trailing).offset(4)
            $0.bottom.equalTo(bookAuthorLabel)
            $0.trailing.equalToSuperview().offset(-15)
        }

        contentView.addSubview(bookDetailLabel)
        bookDetailLabel.snp.makeConstraints{
            $0.top.equalTo(bookAuthorLabel.snp.bottom).offset(2)
            $0.trailing.equalTo(contentView.snp.trailing).offset(-15)
            $0.bottom.equalTo(bookView).offset(-4)
            $0.leading.equalTo(bookAuthorLabel.snp.leading)
        }
    }

    var viewModel:BookDetailViewModel? {
        didSet {
            bookView.AsunSetImage(imageName: staticResources + (viewModel?.coverName ?? ""), placeholder: UIImage.blankImage())
            bookNameLabel.text = viewModel?.bookName
            bookAuthorLabel.text = viewModel?.authorName
            bookExtensionLabel.text = viewModel?.extensionName
            bookDetailLabel.text = viewModel?.contentName
            bookCountLabel.text = viewModel?.countName
            bookPeopleView.snp.updateConstraints{
                $0.width.equalTo(viewModel?.hotSize ?? 0)
            }
            bookAuthorLabel.snp.updateConstraints{
                $0.size.equalTo(viewModel?.authorSize ?? CGSize(width: 0, height: 0))
            }
        }
    }
}

class BookDetailViewModel {
    var model: BooksModule?

    var authorSize:CGSize = CGSize(width: 0, height: 0)
    var hotSize:CGFloat = 0
    var authorName:String = ""
    var bookName:String = ""
    var extensionName:String = ""
    var contentName:String = ""
    var countName:String = ""
    var coverName:String = "'"

    convenience init(model: BooksModule) {
        self.init()
        self.model = model
        coverName = model.cover ?? ""
        authorSize = getSize(content: model.author ?? "", font: pingFangSizeLight(size: 12)).size
        hotSize = (getSize(content: model.latelyFollower , font: pingFangSizeLight(size: 10)).size.width) + 28
        bookName = model.title ?? ""
        authorName = model.author ?? ""
        extensionName = model.minorCate ?? ""
        contentName = model.shortIntro ?? ""
        countName = "\(model.latelyFollower)"
    }

    func getSize<T>(content:T,font:UIFont) -> CGRect {
        return ("\(content)" as NSString).boundingRect(with: CGSize(width: 100, height: 100), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font:font], context: nil)
    }
}
