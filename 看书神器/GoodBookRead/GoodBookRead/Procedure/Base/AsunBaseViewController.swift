//
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//


import UIKit
import SnapKit
import Then
import Reusable
import RxSwift
import RxCocoa
import Alamofire
import Moya

//import Kingfisher

class AsunBaseViewController: UIViewController {

    lazy var reachability: NetworkReachabilityManager? = {
        return NetworkReachabilityManager(host: "www.baidu.com")
    }()


    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.background

        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }

        listenNetwork()

        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    func configUI() {}
    
    func configNavigationBar() {
        guard let navi = navigationController else { return }
        if navi.visibleViewController == self {
            navi.barStyle(.theme)
            navi.disablePopGesture = false
            navi.setNavigationBarHidden(false, animated: true)
            if navi.viewControllers.count > 1 {
                navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back_black")?.withColor(UIColor.black),
                                                                   target: self,
                                                                   action: #selector(pressBack))
            }
        }
    }

    private func listenNetwork() {
        reachability?.listener = { status in
            switch status {
            case .notReachable, .unknown:
                MBProgressExtension.show(addKeyWindowAnimated: true, title: "网络不佳, 请稍后再试~")
            case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                break
            }
        }
        reachability?.startListening()
    }
    
    @objc func pressBack() {
        navigationController?.popViewController(animated: true)
    }

    deinit {
        print("==== \(self.classForCoder) Deinit ===")
    }
}

extension AsunBaseViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .default
    }
}
