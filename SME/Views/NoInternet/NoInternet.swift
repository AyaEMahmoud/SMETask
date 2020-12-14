//
//  NoInternet.swift
//  SME
//
//  Created by Aya Essam on 12/6/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit

protocol NoInternetView: class {
    func tryAgain()
}

class NoInternet: UIView {
    
    @IBOutlet private weak var checkConnectionLable: UILabel!
    @IBOutlet private weak var noInternetLable: UILabel!
         
    weak var view: NoInternetView?
    
    init(with view: NoInternetView) {
      super.init(frame: CGRect.zero)
      self.setupView()
      self.view = view
    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.setupView()
    }
    
    @IBAction func tryAgain(_ sender: UIButton) {
        print(" in action ")
        self.view?.tryAgain()
    }
    
    private func setupView() {
        guard let view = loadViewFromNib() else { return }
        noInternetLable.font = UIFont(font: FontFamily._29LTAzer.bold, size: 18.25)
        checkConnectionLable.font = UIFont(font: FontFamily._29LTAzer.regular, size: 18.25)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
}
