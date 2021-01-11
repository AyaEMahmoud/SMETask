//  ButtonBarExampleViewController.swift
//  XLPagerTabStrip ( https://github.com/xmartlabs/XLPagerTabStrip )
//
//  Copyright (c) 2017 Xmartlabs ( http://xmartlabs.com )
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
import XLPagerTabStrip

class XLPagerTabStripExampleViewController: ButtonBarPagerTabStripViewController, PagerAwareProtocol {
    
    var pageDelegate: BottomPageDelegate?
    var coordinator: MainCoordinator?
    
    var currentViewController: UIViewController?{
        return viewControllers[currentIndex]
    }

    var pagerTabHeight: CGFloat?{
        return 50
    }

    var isReload = false
    var id: String?
    var info: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        settings.style.buttonBarBackgroundColor = UIColor(asset: Asset.Colors.ghostWhite)
        settings.style.buttonBarItemBackgroundColor = UIColor(asset: Asset.Colors.ghostWhite)
        settings.style.selectedBarBackgroundColor = UIColor(asset: Asset.Colors.seaBlue)!
        settings.style.buttonBarItemTitleColor = UIColor(asset: Asset.Colors.seaBlue)
        settings.style.selectedBarHeight = 4

    }

    override func viewDidLoad() {
        styleTapsButton()
        super.viewDidLoad()

        delegate = self

        self.changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?,
                                                newCell: ButtonBarViewCell?,
                                                progressPercentage: CGFloat,
                                                changeCurrentIndex: Bool,
                                                animated: Bool) -> Void in
            
            oldCell?.label.textColor = UIColor(asset: Asset.Colors.ashGrey)
            newCell?.label.textColor = UIColor(asset: Asset.Colors.seaBlue)
        }
        
    }

    // MARK: - PagerTabStripDataSource
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomViewController") as! BottomViewController
        vc.pageIndex = 0
        vc.pageTitle = "جدول الجلسات"
        vc.count = 10
        vc.contributerId = self.id
        vc.coordinator = self.coordinator
        let child1 = vc

        let vc1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomInfoViewController") as! BottomInfoViewController
        vc.pageIndex = 1
        vc1.pageTitle = "معلومات عامة"
        vc1.info = self.info
        let child2 = vc1

        return [child2, child1]
    }

    private func styleTapsButton () {
        settings.style.selectedBarBackgroundColor = UIColor.lightGray
        settings.style.buttonBarBackgroundColor = UIColor(asset: Asset.Colors.ghostWhite)
        settings.style.buttonBarHeight = 45
        settings.style.buttonBarLeftContentInset = 16
        settings.style.buttonBarRightContentInset = 20
        settings.style.buttonBarItemFont = FontFamily._29LTAzer.bold.font(size: 18)
        settings.style.selectedBarBackgroundColor = UIColor(asset: Asset.Colors.seaBlue)!
        settings.style.buttonBarItemBackgroundColor = UIColor(asset: Asset.Colors.ghostWhite)
        settings.style.buttonBarMinimumInteritemSpacing = 5
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
    }
    
    override func reloadPagerTabStripView() {
        pagerBehaviour = .progressive(skipIntermediateViewControllers: arc4random() % 2 == 0, elasticIndicatorLimit: arc4random() % 2 == 0 )
        super.reloadPagerTabStripView()
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController,
                                  fromIndex: Int,
                                  toIndex: Int,
                                  withProgressPercentage progressPercentage: CGFloat,
                                  indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        
        guard indexWasChanged == true else { return }

        //IMPORTANT!!!: call the following to let the master scroll controller know which view to control in the bottom section
        self.pageDelegate?.tp_pageViewController(self.currentViewController, didSelectPageAt: toIndex)

    }
}

