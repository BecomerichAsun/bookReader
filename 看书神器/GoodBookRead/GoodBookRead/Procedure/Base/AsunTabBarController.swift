//
//  UTabBarController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//


import UIKit

class AsunTabBarController: UITabBarController, UITabBarControllerDelegate {

    lazy var selectedDate: Date = Date.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false

        self.delegate = self

        self.selectedIndex = 0

        tabBar.barTintColor = UIColor.blackColor
        
        let extensionVC = ExtensionViewController()

        let vc = ExtensionsViewController()

        let home = HomeViewController()

        let mine =  MineViewController()

        addChildViewController(extensionVC, title: "书架", image: UIImage(named: "SelectedextensionTab"), selectedImage: UIImage(named: "ExtensionTab"))

        addChildViewController(home, title: "书城", image: UIImage(named: "SelectedHomeTab"), selectedImage: UIImage(named: "HomeTab"))

        addChildViewController(vc, title: "热门", image: UIImage(named: "Selectedrecommended"), selectedImage: UIImage(named: "recommended"))

        addChildViewController(mine, title: "我", image: UIImage(named: "SelectedmineTab"), selectedImage: UIImage(named: "MineTab"))
    }
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        let attributes =  [NSAttributedStringKey.foregroundColor: UIColor.whiteColor,
                           NSAttributedStringKey.font:pingFangSizeMedium(size: 24)]
        
        childController.tabBarItem.setTitleTextAttributes(attributes , for: UIControlState.selected)
        childController.tabBarItem.titlePositionAdjustment  = UIOffsetMake(0, 2.5)
        addChildViewController(AsunNavigationController(rootViewController: childController))
    }
}

extension AsunTabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if (tabBarController.selectedViewController?.isEqual(tabBarController.viewControllers?.first.self))! {
            if !(viewController.isEqual(tabBarController.selectedViewController.self)) {
                return true
            }
            let currentDate = Date()
            if currentDate.timeIntervalSince1970 - selectedDate.timeIntervalSince1970 < 0.5 {
                let nav = viewController as! AsunNavigationController
                if nav.viewControllers.count == 0 { return false }
                let home = nav.viewControllers.first as! ExtensionViewController
                home.collectionView.asunHead.beginRefreshing()
                self.selectedDate = Date.init(timeIntervalSince1970: 0)
                return false
            }
            selectedDate = currentDate
        }
        return true
    }
}

