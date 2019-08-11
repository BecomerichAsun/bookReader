//
//  GradientView.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/11.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
   static let shared = GradientView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
    
   private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
}

extension UIView {
    //初始化gradientLayer并设置相关属性
    func createBaseGradientLayer() {
        let loginGradientColors = [UIColor.beginColor.cgColor,UIColor.middleColor.cgColor,UIColor.endColor.cgColor]
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = loginGradientColors
        gradientLayer.locations = [0.0,0.33]
        self.layer.addSublayer(gradientLayer)
    }
}
