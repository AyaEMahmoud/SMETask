//
//  ScheduleViewController.swift
//  SME
//
//  Created by Aya Essam on 24/12/2020.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit

class ScheduleViewController : UIViewController, UIScrollViewDelegate, TPDataSource, TPProgressDelegate {
    
    func headerHeight() -> ClosedRange<CGFloat> {
        let lowerBound = CGFloat(100.0)
        let upperBound = CGFloat(277.0)
        let height = lowerBound...upperBound
        return height
    }
    
    func infiniteScrollTriggered(scroll: UIScrollView) {
        
    }
    
    var headerVC: HeaderViewController?
    var bottomTableVC: BottomViewController?
    
    var schedules = [Schedules]()
    let refresh = UIRefreshControl()
    lazy var presenter = SchedulePresenter(with: self)
    lazy var noInternet = NoInternet(with: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tp_configure(with: self, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func initLoadMore() {
        self.bottomTableVC?.tableView.configRefreshFooter(container: self) {
            self.presenter.page += 1
            self.presenter.getSchedules(contributerId: "")
        }
     }
    
    func initPullToRefresh() {
        self.bottomTableVC?.tableView.configRefreshHeader(container: self) {
            self.presenter.page = 1
            self.presenter.getSchedules(contributerId: "")
        }
    }
    
     func startWindless() {
         self.bottomTableVC?.tableView.windless
             .apply {
                 $0.beginTime = 0
                 $0.pauseDuration = 1
                 $0.duration = 1.5
                 $0.animationLayerOpacity = 0.8
             }
             .start()
     }
    
    @objc func handleRefreshControl() {
        print("refreshing")
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
        return headerVC!
    }
    
    var bottomVC: XLPagerTabStripExampleViewController!
    func bottomViewController() -> UIViewController & PagerAwareProtocol {
        bottomVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "XLPagerTabStripExampleViewController") as! XLPagerTabStripExampleViewController
        
            let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomPageContainerViewController") as! BottomPageContainerViewController
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

extension ScheduleViewController: SchedulePresenterView {
    
    func displayToast(isInternetConnectionError: Bool) {
        if isInternetConnectionError {
//            windlessSetup()
            self.view.makeToast("The Internet connection appears to be offline!", duration: 3.0, position: .bottom)
        } else {
//            windlessSetup()
            self.view.makeToast("Something went wrong!", duration: 3.0, position: .bottom)
        }
    }
    
    func updateCollectionBackground() {
//        self.collectionView.windless.end()
//        self.windelssCount = 0
        self.schedules = []
        self.bottomTableVC?.tableView.isScrollEnabled = false
        self.bottomTableVC?.tableView.switchRefreshHeader(to: .removed)
        self.bottomTableVC?.tableView.reloadData()
        self.bottomTableVC?.tableView.backgroundView = noInternet
    }
    
    func updateModel(schedules: [Schedules]) {
//        windlessSetup()
        initPullToRefresh()
        initLoadMore()
        self.bottomTableVC?.tableView.backgroundView = nil
        self.schedules = schedules
        self.bottomTableVC?.tableView.reloadData()
    }
    
    func windlessSetup() {
//        self.collectionView.switchRefreshFooter(to: .normal)
//        self.collectionView.switchRefreshHeader(to: .normal(.success, 0.0))
//        self.collectionView.windless.end()
//        self.windelssCount = 0
    }
    
    func endLoadMore() {
        self.bottomTableVC?.tableView.switchRefreshFooter(to: .removed)
    }
}

extension ScheduleViewController: NoInternetView {
    
    func tryAgain() {
        print("in try")
        self.presenter.page = 1
//        startWindless()
        initLoadMore()
        initPullToRefresh()
        self.presenter.getSchedules(contributerId: "")
    }
    
}
