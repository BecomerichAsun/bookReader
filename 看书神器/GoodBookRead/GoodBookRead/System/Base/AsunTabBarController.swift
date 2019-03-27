//
//  UTabBarController.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import IconFont

class AsunTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false

        self.selectedIndex = 0
        
        let extensionVC = ExtensionViewController()

        let vc = ExtensionsViewController()

        addChildViewController(extensionVC, title: "分类", image: UIImage(named: "ExtensionTab"), selectedImage: UIImage(named: "SelectedextensionTab"))

        addChildViewController(vc, title: "子分类", image: UIImage(named: "ExtensionTab"), selectedImage: UIImage(named: "SelectedextensionTab"))
    }

    func iconFontToImage(text:String,size:Int,color:UIColor? = UIColor.clear ) -> TBCityIconInfo {
       return TBCityIconInfo(text: text, size: size, color: color)
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        let attributes =  [NSAttributedStringKey.foregroundColor: UIColor(r: 220, g: 104, b: 10).withAlphaComponent(0.8),
                           NSAttributedStringKey.font: UIFont(name: "Heiti SC", size: 24.0)!]
        childController.tabBarItem.setTitleTextAttributes(attributes , for: UIControlState.selected)
        addChildViewController(AsunNavigationController(rootViewController: childController))
    }
}

extension AsunTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}

