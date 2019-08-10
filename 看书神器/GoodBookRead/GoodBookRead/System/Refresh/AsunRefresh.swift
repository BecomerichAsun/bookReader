//
//  URefresh.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    var asunHead: MJRefreshHeader {
        get { return mj_header }
        set { mj_header = newValue }
    }

    var asunFoot: MJRefreshFooter {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
}

class AsunRefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        setImages([UIImage(named: "Refresh_Normal")!], for: .idle)
        setImages([UIImage(named: "Refresh_will_Refresh")!], for: .pulling)
        setImages([UIImage(named: "Animated1")!,
                   UIImage(named: "Animated2")!,
                   UIImage(named: "Animated3")!,
                   UIImage(named: "Animated4")!,
                   UIImage(named: "Animated5")!], for: .refreshing)

        lastUpdatedTimeLabel.isHidden = true
        stateLabel.isHidden = false
        setTitle("下拉刷新", for: .idle)
        setTitle("松开刷新", for: .willRefresh)
        setTitle("好好看书", for: .refreshing)
        setTitle("松开刷新", for: .pulling)
    }
}

class AsunRefreshAutoHeader: MJRefreshHeader {}

class AsunRefreshFooter: MJRefreshBackNormalFooter {}

class AsunRefreshAutoFooter: MJRefreshAutoFooter {}

class AsunRefreshDiscoverFooter: MJRefreshBackGifFooter {

    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.background
        setImages([UIImage(named: "refresh_discover")!], for: .idle)
        setTitle("人家是有底线的!", for: .refreshing)
        setTitle("人家是有底线的!", for: .willRefresh)
        setTitle("人家是有底线的!", for: .idle)
        setTitle("人家是有底线的!", for: .pulling)
        setTitle("人家是有底线的!", for: .noMoreData)
        stateLabel.asunMargin.changeLabelRowSpace(lineSpace: 0, wordSpace: 2)
        refreshingBlock = { self.endRefreshing() }
    }
}

class AsunRefreshTipKissFooter: MJRefreshBackFooter {

    lazy var tipLabel: UILabel = {
        let tl = UILabel()
        tl.textAlignment = .center
        tl.textColor = UIColor.lightGray
        tl.font = UIFont.systemFont(ofSize: 14)
        tl.numberOfLines = 0
        return tl
    }()

    lazy var imageView: UIImageView = {
        let iw = UIImageView()
        iw.image = UIImage(named: "refresh_kiss")
        iw.contentMode = .scaleAspectFill
        return iw
    }()

    override func prepare() {
        super.prepare()
        backgroundColor = UIColor.background
        mj_h = 108
        addSubview(tipLabel)
        addSubview(imageView)
    }

    override func placeSubviews() {
        tipLabel.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 50)
        imageView.frame = CGRect(x: (bounds.width - 50)/2, y: 50, width: 48, height: 48)
    }

    convenience init(with tip: String) {
        self.init()
        refreshingBlock = { self.endRefreshing() }
        tipLabel.text = tip
    }
}



