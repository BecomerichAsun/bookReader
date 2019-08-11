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
        static var asunEmptyKey: Void?
    }

    var asunempty: AsunEmptyView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.asunEmptyKey) as? AsunEmptyView
        }
        set {
            self.emptyDataSetDelegate = newValue
            self.emptyDataSetSource = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.asunEmptyKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

class AsunEmptyView: EmptyDataSetSource, EmptyDataSetDelegate {

    var image: UIImage?
    var title: NSAttributedString?

    var titleString:String?

    var allowShow: Bool = false
    var verticalOffset: CGFloat = 0


    private var tapClosure: (() -> Void)?

    init(image: UIImage? = UIImage(named: "nodata"),title:NSAttributedString? = NSAttributedString(string: "数据不见啦~"),titleString:String? = "数据不见啦~", verticalOffset: CGFloat = 0, tapClosure: (() -> Void)?) {
        self.image = image
        self.title = title
        self.verticalOffset = verticalOffset
        self.tapClosure = tapClosure
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView) -> CGFloat {
        return verticalOffset
    }

    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
       let att = [NSAttributedStringKey.foregroundColor: UIColor.blackColor.withAlphaComponent(0.8),
         NSAttributedStringKey.font:pingFangSizeMedium(size: 15)]
        title = NSAttributedString(string: self.titleString ?? "", attributes: att)
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




