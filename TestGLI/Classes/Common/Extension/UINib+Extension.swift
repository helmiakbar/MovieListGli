//
//  UINib+Extension.swift
//  TestGLI
//
//  Created by SehatQ on 11/02/23.
//

import UIKit

extension UIView {
    static func getFirstNib() -> UIView {
        return UINib(nibName: self.className(), bundle: nil).instantiate(withOwner: nil, options: nil).first as! UIView
    }
}
