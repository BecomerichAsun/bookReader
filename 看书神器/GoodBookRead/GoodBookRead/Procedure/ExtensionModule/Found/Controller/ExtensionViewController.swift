//
//  ExtensionViewController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//

//https://xiadd.github.io/zhuishushenqi/#/?id=开发与部署

//https://github.com/dengzemiao/DZMeBookRead

//WHC_DataModelFactory

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

class ExtensionViewController: AsunBaseViewController,ActionExtensionProtocol {
    
    lazy var collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.minimumInteritemSpacing = 10
        lt.minimumLineSpacing = 13
        lt.sectionHeadersPinToVisibleBounds = true  
        let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        cw.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        cw.alwaysBounceVertical = true
        cw.showsVerticalScrollIndicator = false
        cw.showsHorizontalScrollIndicator = false
        cw.decelerationRate = UIScrollViewDecelerationRateFast
        view.addSubview(cw)
        return cw
    }()

    lazy var bag = DisposeBag()

    lazy var viewModel = ExtensionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let a = RequestService.requestLogin(username: "18616743904", password: "asun199591")
        a.subscribe(onNext: { (model) in
        }).disposed(by: bag)
        let value = HTTPCookieStorage.shared
        print("剩余\(value.cookies))")

        let url1 = URL(string: "https://shuapi.jiaston.com/Login.aspx")!

        let cstorage1 = HTTPCookieStorage.shared

        if let cookies = cstorage1.cookies(for: url1) {
            for cookie:HTTPCookie in cookies {
                print("登录name：\(cookie.name)", "value：\(cookie.value)")
            }
        }

        let url = URL(string: "https://shuapi.jiaston.com/Bookshelf.aspx")!
        let cstorage = HTTPCookieStorage.shared
        if let cookies = cstorage.cookies(for: url) {
            for cookie:HTTPCookie in cookies {
                print("收藏name：\(cookie.name)", "value：\(cookie.value)")
            }
        }

//        let a = RequestService.requestLocalBook()
//        a.subscribe(onNext: { (model) in
//            AsunLog(model)
//        }).disposed(by: bag)

//        print(cstorage.cookies)
    }
    
    override func configUI() {
        view.backgroundColor = UIColor.background
        collectionView.snp.makeConstraints{$0.edges.equalTo(view.usnp.edges)}
//        viewModel.driverData(inputView: collectionView, depency: (action: self, bag: bag))
    }

    func didSelected(data: ExtensionCellViewModel, extensionName: String) {
        let detailParams:BookeDetailParams = BookeDetailParams(extensionName, data.name.value, 0, 20, data.name.value)
        let bookDetailVC = BookExtensionDetailViewController(params: detailParams)
        self.navigationController?.pushViewController(bookDetailVC, animated: true)
    }
}
