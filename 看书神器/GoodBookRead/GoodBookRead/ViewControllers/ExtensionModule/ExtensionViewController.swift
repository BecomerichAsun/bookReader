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
import Then
import Reusable

class ExtensionViewController: AsunBaseViewController {

    var headerReusableView:UICollectionReusableView?

    private lazy var headerTextArray:[String] = ["男生",
                                                 "女生",
                                                 "趣味",
                                                 "文学"]

    private lazy var collectionView: UICollectionView = {
        let lt = UICollectionViewFlowLayout()
        lt.minimumInteritemSpacing = 10
        lt.minimumLineSpacing = 13
        lt.sectionHeadersPinToVisibleBounds = true  
        let cw = UICollectionView(frame: CGRect.zero, collectionViewLayout: lt)
        cw.backgroundColor = UIColor.hex(hexString: "#FFFFFF").withAlphaComponent(0.8)
        cw.delegate = self
        cw.dataSource = self
        cw.alwaysBounceVertical = true
        cw.showsVerticalScrollIndicator = false
        cw.showsHorizontalScrollIndicator = false
        cw.decelerationRate = UIScrollViewDecelerationRateFast
        cw.asunHead = AsunRefreshHeader { [weak self] in
            guard let `self` = self else { return }
            self.request()
        }
        cw.asunFoot = AsunRefreshDiscoverFooter()
        cw.register(supplementaryViewType: ExtensionHeaderView.self, ofKind: UICollectionElementKindSectionHeader)
        cw.register(cellType: ParentExtensionCollectionViewCell.self)
        return cw
    }()

    var requestData:ParentExtensionModule?

    override func viewDidLoad() {
        super.viewDidLoad()
        request()
        view.backgroundColor = UIColor.background
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints{$0.edges.equalTo(self.view.usnp.edges)}
    }
}

extension ExtensionViewController {
    func request() {
        Network.request(true, AsunAPI.parentCategoryNumberOfBooks, ParentExtensionModule.self, success: { [weak self](value) in
            guard let `self` = self else { return }
            self.requestData = value
            self.collectionView.reloadData(animation: true)
            self.collectionView.asunHead.endRefreshing()
            }, error: { (_) in

        }) { (_) in

        }
    }
}

extension ExtensionViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = floor(Double(screenWidth - 45.0) / 3.0)
        return CGSize(width: width, height: width * 0.75 + 110)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: screenWidth - 20, height: 34)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
            let head = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, for: indexPath, viewType: ExtensionHeaderView.self)
            head.setHeaderProprety(headerTextArray[indexPath.section], imgName: "\(indexPath.section)")
           return head
    }
}
