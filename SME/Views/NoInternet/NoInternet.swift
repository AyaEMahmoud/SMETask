//
//  NoInternet.swift
//  SME
//
//  Created by Aya Essam on 12/6/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit

class NoInternet: UIView {
    
    init() {
      super.init(frame: CGRect.zero)
      self.setupView()
    }
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.setupView()
    }
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.setupView()
    }
    
    private func setupView() {
      guard let view = loadViewFromNib() else { return }
      view.frame = self.bounds
      view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      self.addSubview(view)
    }
    
}