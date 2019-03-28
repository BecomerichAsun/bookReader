//
//  Gloabl.swift
//  ASUN-BOOM-EXTENSION
//
//  Created by Asun on 2019/3/26.
//  Copyright © 2019年 Asun. All rights reserved.
//


import Foundation
import EmptyDataSet_Swift

extension UIScrollView {

    private struct AssociatedKeys {
        static var uemptyKey: Void?
    }

    var asunempty: AsunEmptyView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.uemptyKey) as? AsunEmptyView
        }
        set {
            self.emptyDataSetDelegate = newValue
            self.emptyDataSetSource = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.uemptyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class AsunEmptyView: EmptyDataSetSource, EmptyDataSetDelegate {

    var image: UIImage?
    var title: NSAttributedString?

    var allowShow: Bool = false
    var verticalOffset: CGFloat = 0


    private var tapClosure: (() -> Void)?

    init(image: UIImage? = UIImage(named: "nodata"),title:NSAttributedString = NSAttributedString(string: "数据不见啦~"), verticalOffset: CGFloat = 0, tapClosure: (() -> Void)?) {
        self.image = image
        self.title = title
        self.verticalOffset = verticalOffset
        self.tapClosure = tapClosure
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }

    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return title
    }

    internal func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return image
    }

    internal func emptyDataSetShouldDisplay(_ scrollView: UIScrollView) -> Bool {
        return allowShow
    }

    internal func emptyDataSet(_ scrollView: UIScrollView, didTapView view: UIView) {
        guard let tapClosure = tapClosure else { return }
        tapClosure()
    }
}




