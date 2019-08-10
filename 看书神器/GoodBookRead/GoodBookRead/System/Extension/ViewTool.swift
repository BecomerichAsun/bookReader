//
//  ViewTool.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/10.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit

class ViewTool {
    
    static func SetMutiBorderRoundingCorners(_ view: UIView,roundingCorners: UIRectCorner,corner: CGFloat) {
        
        let maskPath = UIBezierPath.init(roundedRect: view.bounds,
                                         
                                         byRoundingCorners: roundingCorners,
                                         
                                         cornerRadii: CGSize(width: corner, height: corner))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.frame = view.bounds
        
        maskLayer.path = maskPath.cgPath
        
        view.layer.mask = maskLayer
        
    }
}
