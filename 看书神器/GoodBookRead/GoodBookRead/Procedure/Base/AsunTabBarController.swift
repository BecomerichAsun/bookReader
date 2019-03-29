//
//  UTabBarController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//


import UIKit

class AsunTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false

        self.selectedIndex = 0

        self.tabBar.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        
        let extensionVC = ExtensionViewController()

        let vc = ExtensionsViewController()

        let home = HomeViewController()

        let mine =  MineViewController()

        addChildViewController(extensionVC, title: "发现", image: UIImage(named: "ExtensionTab"), selectedImage: UIImage(named: "SelectedextensionTab"))

        addChildViewController(home, title: "书架", image: UIImage(named: "HomeTab"), selectedImage: UIImage(named: "SelectedHomeTab"))

        addChildViewController(vc, title: "推荐", image: UIImage(named: "recommended"), selectedImage: UIImage(named: "Selectedrecommended"))

        addChildViewController(mine, title: "我", image: UIImage(named: "MineTab"), selectedImage: UIImage(named: "SelectedMineTab"))
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        let attributes =  [NSAttributedStringKey.foregroundColor: UIColor(r: 220, g: 104, b: 10).withAlphaComponent(0.8),
                           NSAttributedStringKey.font:pingFangSizeMedium(size: 22)]
        childController.tabBarItem.setTitleTextAttributes(attributes , for: UIControlState.selected)
        childController.tabBarItem.titlePositionAdjustment  = UIOffsetMake(0, 2.5)
        addChildViewController(AsunNavigationController(rootViewController: childController))
    }
}

extension AsunTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
}

