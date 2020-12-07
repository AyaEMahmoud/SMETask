//
//  UIButton+Extentions.swift
//  SME
//
//  Created by Aya Essam on 12/6/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit

@IBDesignable extension UIButton {

    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
                   layer.borderWidth = newValue
        }
    }

    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }

    @IBInspectable
    var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
    }
}
