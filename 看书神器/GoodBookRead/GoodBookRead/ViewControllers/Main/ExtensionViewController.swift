//
//  ExtensionViewController.swift
//  GoodBookRead
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//

//https://xiadd.github.io/zhuishushenqi/#/?id=开发与部署

//https://github.com/dengzemiao/DZMeBookRead

import UIKit
import Then
import Reusable
class ExtensionViewController: AsunBaseViewController {

    private lazy var collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.sectionInset = UIEdgeInsets(top: 5, left: 10, bottom: 10, right: 10)
        lt.minimumInteritemSpacing = 5
        lt.minimumLineSpacing = 10
        lt.itemSize = CGSize(width: floor((screenWidth - 30) / 2), height:floor(screenHeight/5))
        let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        cw.backgroundColor = UIColor.background
        cw.delegate = self
        cw.dataSource = self
        cw.alwaysBounceVertical = true
        cw.register(cellType: ParentExtensionCollectionViewCell.self)
        return cw
    }()

    var requestData:ParentExtensionModule?

    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        view.backgroundColor = UIColor.background
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{
            $0.edges.equalTo(self.view)
        }
    }
}

extension ExtensionViewController {
    func request() {
        Network.request(true, AsunAPI.parentCategoryNumberOfBooks, ParentExtensionModule.self, success: { [weak self](value) in
            guard let `self` = self else { return }
            self.requestData = value
            DispatchQueue.main.async {
                self.collectionView.reloadData(animation: true)
            }
            }, error: { (_) in

        }) { (_) in

        }
    }
}

extension ExtensionViewController:UICollectionViewDelegate,UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return requestData?.male?.count ?? 0
        } else if section == 1 {
            return requestData?.female?.count ?? 0
        } else if section == 2 {
            return requestData?.picture?.count ?? 0
        } else {
            return requestData?.press?.count ?? 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as ParentExtensionCollectionViewCell
        guard requestData != nil else {return cell}
        if indexPath.section == 0 {
            cell.model = requestData?.male?[indexPath.item]
        } else if indexPath.section == 1 {
            cell.model = requestData?.female?[indexPath.item]
        } else if indexPath.section == 2 {
            cell.model = requestData?.picture?[indexPath.item]
        } else {
            cell.model = requestData?.press?[indexPath.item]
        }
        return cell
    }
}
