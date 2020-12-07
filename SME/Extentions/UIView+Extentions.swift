//
//  UIView+Extentions.swift
//  SME
//
//  Created by Aya Essam on 12/6/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit

extension UIView {
  func loadViewFromNib<T: UIView>() -> T? {
    guard let contentView = Bundle(for: type(of: self)).loadNibNamed(String(describing: type(of: self)), owner: self, options: nil)?.first as? T else {
      // xib not loaded, or its top view is of the wrong type
      return nil
    }
    return contentView
  }
}
