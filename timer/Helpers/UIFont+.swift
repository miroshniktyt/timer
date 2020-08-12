//
//  UIFont+.swift
//  timer
//
//  Created by Macbook Air on 12.08.2020.
//  Copyright © 2020 macbook. All rights reserved.
//

import UIKit

extension UIFont {
    static var inAppItalic: UIFont {
        let font = UIFont.italicSystemFont(ofSize: 22)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        return fontMetrics.scaledFont(for: font)
    }
    
    static var inAppSmall: UIFont {
        let font = UIFont.monospacedDigitSystemFont(ofSize: 24, weight: .light)
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        return fontMetrics.scaledFont(for: font)
    }
    
    static var inAppBig: UIFont {
        return .monospacedDigitSystemFont(ofSize: 400, weight: .thin)
    }
}
