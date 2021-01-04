//
//  ScheduleViewController.swift
//  SME
//
//  Created by Aya Essam on 24/12/2020.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit

class ScheduleViewController : UIViewController,
                               UIScrollViewDelegate,
                               TPDataSource,
                               TPProgressDelegate {
    
    func headerHeight() -> ClosedRange<CGFloat> {
        let lowerBound = CGFloat(100.0)
        let upperBound = CGFloat(297.0)
        let height = lowerBound...upperBound
        return height
    }
    
    func infiniteScrollTriggered(scroll: UIScrollView) {
        
    }
    
    var coordinator: MainCoordinator?
    var headerVC: HeaderViewController?
//    var bottomTableVC: BottomViewController?
    var profile: Profiles?
    let refresh = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tp_configure(with: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func handleRefreshControl() {
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.refresh.endRefreshing()
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    //MARK: TPDataSource
    func headerViewController() -> UIViewController {
        headerVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HeaderViewController") as? HeaderViewController

        if let profile = self.profile {
            self.headerVC?.profile = profile
        }
        return headerVC!
    }
    
    var bottomVC: XLPagerTabStripExampleViewController!
    func bottomViewController() -> UIViewController & PagerAwareProtocol {
        
        bottomVC = UIStoryboard.init(name: "Main",
                                     bundle: nil).instantiateViewController(withIdentifier: "XLPagerTabStripExampleViewController") as! XLPagerTabStripExampleViewController
        if let profile = self.profile {
            self.bottomVC?.id = profile.id
            self.bottomVC.info = profile.subject?.title
        }
        
        bottomVC.coordinator = self.coordinator
        
        return bottomVC
    }
    
    //stop scrolling header at this point
    func minHeaderHeight() -> CGFloat {
        return (topInset + 120)
    }
    
    //MARK: TPProgressDelegate
    func tp_scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat) {
        headerVC?.update(with: progress, minHeaderHeight: minHeaderHeight())
    }
    
    func tp_scrollViewDidLoad(_ scrollView: UIScrollView) {
        
        refresh.tintColor = .white
        refresh.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        
        let refreshView = UIView(frame: CGRect(x: 0, y: 120, width: 0, height: 0))
        scrollView.addSubview(refreshView)
        refreshView.addSubview(refresh)
    }
}

