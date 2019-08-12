//
//  DictionaryExtension.swift
//  GoodBookRead
//
//  Created by Asun on 2019/8/12.
//  Copyright © 2019 Asun. All rights reserved.
//

import UIKit

extension Dictionary where Key == NSAttributedStringKey {

    func toTypingAttributes() -> [String: Any] {
        var convertedDictionary = [String: Any]()
        for (key, value) in self {
            convertedDictionary[key.rawValue] = value
        }
        return convertedDictionary
    }
}

extension String {
    func stringSize( font: UIFont) -> CGRect {
        let string: NSString = self as NSString
        let att = [NSAttributedStringKey.font : font]
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let rect = string.boundingRect(with: CGSize(width: screenWidth*0.8 - 50, height: 50), options: option, attributes: att, context: nil)
        return rect
    }
}
