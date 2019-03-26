//
//  BaseTableViewCell.swift
//  ASUN-BOOM-EXTENSION
//
//  Created by Asun on 2019/1/17.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit
import Reusable

class AsunBaseTableViewCell: UITableViewCell, Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}

}
