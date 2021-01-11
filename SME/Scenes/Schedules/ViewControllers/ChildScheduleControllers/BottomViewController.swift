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

class BottomViewController: UIViewController,
                            UITableViewDataSource,
                            UITableViewDelegate,
                            ReservationProtocal {
    
    @IBOutlet weak var sessionsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var pageIndex: Int = 0
    var pageTitle: String?
    var windelssCount = 10
    var count = 0
    var schedulesData = [SchedulesData]()
    var coordinator: MainCoordinator?
    lazy var presenter = SchedulePresenter(with: self)
    lazy var noInternet = NoInternet(with: self)
    var contributerId: String?
    var info: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sessionsLabel.font = UIFont(font: FontFamily._29LTAzer.bold, size: 22)
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "TableViewCell")
        if let id = self.contributerId {
            presenter.getSchedules(contributerId: id)
        }
    }
    
    func initLoadMore() {
        self.tableView.configRefreshFooter(container: self) {
            self.presenter.page += 1
            self.presenter.getSchedules(contributerId: "")
        }
     }
    
    func initPullToRefresh() {
        self.tableView.configRefreshHeader(container: self) {
            self.presenter.page = 1
            self.presenter.getSchedules(contributerId: "")
        }
    }
    
     func startWindless() {
         self.tableView.windless
             .apply {
                 $0.beginTime = 0
                 $0.pauseDuration = 1
                 $0.duration = 1.5
                 $0.animationLayerOpacity = 0.8
             }
             .start()
     }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedulesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        cell.delegate = self
        
        if !schedulesData.isEmpty {
            cell.schedule = schedulesData[indexPath.row].schedules ?? []
            let scheduleData = schedulesData[indexPath.row]
            cell.setCellData(schedulesData: scheduleData)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func loadReservationScreen(schedule: [Schedules], date: String) {

        let vc = ReservationViewController()
        vc.schedule = schedule
        vc.date = date
        let sheetController = SheetViewController(controller: vc, sizes: [.fixed(420), .fullscreen])
        self.present(sheetController, animated: true, completion: nil)
        
    }
    
}

extension BottomViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo.init(title: pageTitle ?? "Tab \(pageIndex)")
    }
}


extension BottomViewController: SchedulePresenterView {
    
    func displayToast(isInternetConnectionError: Bool) {
        if isInternetConnectionError {
            windlessSetup()
            self.view.makeToast("The Internet connection appears to be offline!", duration: 3.0, position: .bottom)
        } else {
            windlessSetup()
            self.view.makeToast("Something went wrong!", duration: 3.0, position: .bottom)
        }
    }
    
    func updateCollectionBackground() {
        self.tableView.windless.end()
        self.windelssCount = 0
        self.schedulesData = []
        self.tableView.isScrollEnabled = false
        self.tableView.switchRefreshHeader(to: .removed)
        self.tableView.reloadData()
        self.tableView.backgroundView = noInternet
    }
    
    func updateModel(schedulesData: [SchedulesData]) {
        windlessSetup()
        initPullToRefresh()
        initLoadMore()
        self.tableView.backgroundView = nil
        self.schedulesData = schedulesData
        self.tableView.reloadData()
    }
    
    func windlessSetup() {
        self.tableView.switchRefreshFooter(to: .normal)
        self.tableView.switchRefreshHeader(to: .normal(.success, 0.0))
        self.tableView.windless.end()
        self.windelssCount = 0
    }
    
    func endLoadMore() {
        self.tableView.switchRefreshFooter(to: .removed)
    }
}

extension BottomViewController: NoInternetView {
    
    func tryAgain() {
        self.presenter.page = 1
        startWindless()
        initLoadMore()
        initPullToRefresh()
        self.presenter.getSchedules(contributerId: "")
    }
    
}
