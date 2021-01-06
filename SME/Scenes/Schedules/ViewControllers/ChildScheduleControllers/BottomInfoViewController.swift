//
//  BottomViewController.swift
//  TwitterProfile
//
//  Created by OfTheWolf on 08/18/2019.
//  Copyright (c) 2019 OfTheWolf. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import FittedSheets

class BottomInfoViewController: UIViewController {
        
    @IBOutlet weak var infoLabel: UILabel!
    
    var info: String?
    var pageTitle: String?
    var pageIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        infoLabel.text = info
        infoLabel.font = UIFont(font: FontFamily._29LTAzer.bold, size: 21.9)
    }
    
}

extension BottomInfoViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: pageTitle ?? "Tab \(pageIndex)")
    }
}
