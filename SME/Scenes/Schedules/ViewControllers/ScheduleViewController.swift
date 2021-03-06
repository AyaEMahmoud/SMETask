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
    
    
    var coordinator: MainCoordinator?
    var headerVC: HeaderViewController?
    var bottomTableVC: BottomViewController?
    var profile: Profiles?
    let refresh = UIRefreshControl()
    let refreshControl = UIRefreshControl()
    var refreshView = UIView(frame: CGRect(x: 0, y: 230, width: 0, height: 0))
    var scrollView = UIScrollView()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tp_configure(with: self, delegate: self)
    }
    
    func tp_refreshController() -> UIRefreshControl {
        refreshControl.isHidden = false
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        return refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc func handleRefreshControl() {
        print("refresh")
        self.bottomTableVC?.initPullToRefresh()
        self.refresh.endRefreshing()
    }
    
    func headerHeight() -> ClosedRange<CGFloat> {
        let lowerBound = UIScreen.main.bounds.height * 0.2
        let upperBound = CGFloat(297.0)
        return (topInset + lowerBound )...upperBound
        
    }
    func infiniteScrollTriggered(scroll: UIScrollView) {
        self.refresh.endRefreshing()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            scroll.scrollsToTop = true
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
        headerVC?.coordinator = self.coordinator
        return headerVC!
    }
    
    var bottomVC: XLPagerTabStripExampleViewController!
    func bottomViewController() -> UIViewController & PagerAwareProtocol {
        
        bottomVC = UIStoryboard.init(name: "Main",
                                     bundle: nil)
            .instantiateViewController(withIdentifier: "XLPagerTabStripExampleViewController") as! XLPagerTabStripExampleViewController
        
        if let profile = self.profile {
            self.bottomVC?.id = profile.id
            self.bottomVC.info = profile.subject?.title
        }
        
        bottomVC.coordinator = self.coordinator
        
        return bottomVC
    }
    
    //stop scrolling header at this point
    func minHeaderHeight() -> CGFloat {
        return (topInset + 90)
    }
    
    //MARK: TPProgressDelegate
    func tp_scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat) {
        headerVC?.update(with: progress, headerHeight: headerHeight())
    }
    
    func tp_scrollViewDidLoad(_ scrollView: UIScrollView) {
        
        self.scrollView = scrollView
        refresh.tintColor = UIColor.gray
        refresh.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        scrollView.addSubview(refreshView)
        refreshView.addSubview(refresh)
    }
}

