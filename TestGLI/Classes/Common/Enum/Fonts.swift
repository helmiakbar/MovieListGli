//
//  Fonts.swift
//  TestGLI
//
//  Created by SehatQ on 10/02/23.
//

import UIKit

enum Fonts: String {
    case Regular = "OpenSans"
    case Bold = "OpenSans-Bold"
    case Light = "OpenSans-Light"
    case Italic = "OpenSans-Italic"
    case ExtraBold = "OpenSans-ExtraBold"
    case SemiBold = "OpenSans-Semibold"
    case PoppinsSemiBold = "Poppins-SemiBold"
    case PoppinsRegular = "Poppins-Regular"
    case SemiBoldItalic = "OpenSans-SemiboldItalic"

    func font(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: self.rawValue, size: size) {
            return font
        }
        return UIFont.systemFont(ofSize: size)
    }
}
