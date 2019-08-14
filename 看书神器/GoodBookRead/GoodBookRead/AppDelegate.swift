//
//  AppDelegate.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//


// 图片静态地址
// https://imgapi.jiaston.com/BookFiles/BookImages/
// 接口地址
// https://xiadd.github.io/zhuishushenqi/#/?id=开发与部署
// 字典转模型 工具
//WHC_DataModelFactory

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "www.baidu.com")
    }()
    
    var vc: UIViewController?
    
    var isReachability: Bool?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        if UserDefaults.standard.string(forKey: UserDefaultsKey.username.rawValue)?.isEmpty ?? true {
            vc = LoginViewController()
        } else {
            vc = AsunTabBarController()
        }
        window?.rootViewController = vc
        listenNetwork()
        return true
    }
    
    private func listenNetwork() {
        reachability?.startListening()
        reachability?.listener = { [weak self] status in
            guard let `self` = self else { return }
            switch status {
            case .notReachable, .unknown:
                self.isReachability = false
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                self.isReachability = true
                break
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

