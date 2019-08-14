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
        gradientLayer.locations = [0.0,0.35]
        self.layer.addSublayer(gradientLayer)
    }

    func createPointGradientLayer() {
        let loginGradientColors = [UIColor.hex(hexString: "f6d365").cgColor,UIColor.hex(hexString: "fda085 ").cgColor]
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = loginGradientColors
        gradientLayer.locations = [0.0,0.5]
        self.layer.addSublayer(gradientLayer)
    }

    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
}
