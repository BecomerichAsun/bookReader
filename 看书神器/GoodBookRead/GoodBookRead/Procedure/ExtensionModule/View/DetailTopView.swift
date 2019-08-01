//
//  DetailTopView.swift
//  GoodBookRead
//
//  Created by Asun on 2019/4/1.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class DetailTopView: UIView {

    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var lineWidth: NSLayoutConstraint!
    @IBOutlet weak var bookName: UILabel!

    @IBOutlet weak var bookAuthor: UIButton!
    @IBOutlet weak var bookType: UILabel!
    @IBOutlet weak var bookWordCount: UILabel!
    @IBOutlet weak var bookFinished: UILabel!

    @IBOutlet weak var scoreLabel: UILabel!

    @IBOutlet weak var scoreTextLabel: UILabel!
    
    @IBOutlet weak var retainedLabel: UILabel!
    @IBOutlet weak var retainedTextLabel: UILabel!
    @IBOutlet weak var peopelLabel: UILabel!
    @IBOutlet weak var peopleTextLabel: UILabel!
    @IBOutlet weak var contentNormalLabel: UILabel!

    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    @IBOutlet weak var contentWidth: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        bookImage.layer.shadowColor = UIColor.gray.cgColor
        bookImage.layer.shadowOffset = CGSize(width: 3, height: 0)
        bookImage.layer.shadowOpacity = 0.8
        self.contentLabel.isUserInteractionEnabled = true
        
        contentWidth.constant = screenWidth - 40
        self.contentView.addTapCallBack {
            if self.contentHeight.constant == 40 {
                self.contentHeight.constant = self.viewModel?.contenHeight ?? 0
            } else {
                self.contentHeight.constant = 40
            }
        }
    }

    class func creatDetailTopView() -> DetailTopView {
        return Bundle.main.loadNibNamed("DetailTopView", owner: nil, options: nil)?.last as! DetailTopView
    }
    
    var viewModel:DetailViewModel? {
        didSet{
            bookImage.AsunSetImage(imageName: (viewModel?.avater ?? ""), placeholder: UIImage.blankImage())
            bookAuthor.setTitle(viewModel?.author ?? "", for: .normal)
            bookName.text = viewModel?.bookName ?? ""
            bookFinished.text = viewModel?.isFinished ?? ""
            bookWordCount.text = viewModel?.wordCount ?? ""
            bookType.text = viewModel?.bookType ?? ""
            lineWidth.constant = 2

            scoreTextLabel.text = "评分"
            retainedTextLabel.text = "读者留存"
            peopleTextLabel.text = "人气"
            contentNormalLabel.text = "简介"
            scoreLabel.text = viewModel?.score ?? ""
            peopelLabel.text = viewModel?.peopleCount ?? ""
            retainedLabel.text = viewModel?.retainedCount ?? ""
            contentLabel.text = viewModel?.content ?? ""
        }
    }
}


class DetailViewModel {

    var model: BookIdDetailModule?
    //    作者
    var author:String?
    //    书名
    var bookName:String?
    //   是否完结
    var isFinished:String?
    // 字数
    var wordCount:String?
    // 头像
    var avater:String?
    // 类型
    var bookType:String?
    //  评分
    var score:String?
    // 人气
    var peopleCount:String?
    // 留存
    var retainedCount:String?

    var contenHeight:CGFloat?
    //  书籍详情
    var content:String?
    convenience init(model:BookIdDetailModule) {
        self.init()
        self.model = model
        creatViewModelModule()
    }

    func creatViewModelModule() {
        author = model?.author ?? ""
        bookName = model?.title ?? ""
        isFinished = (model?.isFineBook ?? false) ? "已完结" : "连载中"
        avater = staticResources + (model?.cover ?? "")
        wordCount = ((model?.wordCount ?? 0) >= 10000) ? "\((model?.wordCount ?? 0)/10000)万" : "\(model?.wordCount ?? 0)"
        bookType = model?.minorCate
        peopleCount = "\(model?.latelyFollower ?? 0)"
        score = String(format: "%.2f", model?.rating?.score ?? 0.0)
        retainedCount = "\(model?.retentionRatio ?? "")%"
        content = model?.longIntro ?? ""
        contenHeight = getSize(content: content, font: pingFangSizeRegular(size: 12)).height
    }
}
