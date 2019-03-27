//
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//


import UIKit
import Reusable

class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView, Reusable {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}

}
