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
    }
    
    override func configUI() {
        view.backgroundColor = UIColor.background
        collectionView.snp.makeConstraints{$0.edges.equalTo(view.usnp.edges)}
        viewModel.driverData(inputView: collectionView, depency: (action: self, bag: bag))
    }

    func didSelected(data: ExtensionCellViewModel, extensionName: String) {
        let detailParams:BookeDetailParams = BookeDetailParams(extensionName, data.name.value, 0, 20, data.name.value)
        let bookDetailVC = BookExtensionDetailViewController(params: detailParams)
        self.navigationController?.pushViewController(bookDetailVC, animated: true)
    }
}
