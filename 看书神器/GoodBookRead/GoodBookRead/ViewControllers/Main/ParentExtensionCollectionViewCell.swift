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

class ParentExtensionCollectionViewCell: UICollectionViewCell,NibReusable {

    @IBOutlet weak var extensionImageView: UIImageView!
    @IBOutlet weak var extensionTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        extensionImageView.layer.cornerRadius = 15
        extensionImageView.layer.borderWidth = 0.5
        extensionImageView.layer.borderColor = UIColor.hex(hexString: "#FFFFFF").cgColor
        extensionImageView.contentMode = .scaleAspectFill
    }

    var model: ExtensionModule? {
        didSet {
            guard var model = model else { return }
            let image = model.creatImg()
            extensionImageView.yy_setImage(with: URL(string: image)!, placeholder: nil, options: .ignoreDiskCache, completion: nil)
            extensionTitleLabel.text = model.name
        }
    }
}

struct ParentExtensionModule: HandyJSON {
    var male:[ExtensionModule]?
    var female:[ExtensionModule]?
    var picture:[ExtensionModule]?
    var press:[ExtensionModule]?
    var ok:String?
}

struct ExtensionModule: HandyJSON {
    var bookCount: Int = 0
    var icon: String?
    var monthlyCount: Int = 0
    var name: String?
    var bookCover: [String]?

    mutating func creatImg() -> String {
        var image:String = ""
        if bookCover?.count ?? 0 > 0 {
            image = "http://statics.zhuishushenqi.com" + (bookCover?[0] ?? "")
        }
        return image
    }
}
