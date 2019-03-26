//
//  BaseCollectionViewCell.swift
//  ASUN-BOOM-EXTENSION
//
//  Created by Asun on 2019/1/17.
//  Copyright © 2019年 Asun. All rights reserved.
//

import UIKit
import Reusable

class AsunBaseCollectionViewCell: UICollectionViewCell, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}
