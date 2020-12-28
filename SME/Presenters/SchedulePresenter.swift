//
//  SchedulePresenter.swift
//  SME
//
//  Created by Aya Essam on 28/12/2020.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit
import Moya
import Alamofire

protocol SchedulePresenterView: class {
    func updateModel(schedules: [Schedules])
    func updateCollectionBackground()
    func displayToast(isInternetConnectionError: Bool)
    func endLoadMore()
}

class SchedulePresenter {
    
    weak var view: SchedulePresenterView?
    
    let networkManager = SchedulesService()
    var page = 1
    var schedule: [Schedules] = []
    
    init(with view: SchedulePresenterView) {
    self.view = view

    }
    
    func getSchedules(contributerId: String) {
        if !InternetChecker.isConnectedToNetwork() && page == 1 {
            self.view?.updateCollectionBackground()
        } else {
         
            networkManager.getSchedules(contributerId: contributerId) { (schedules, error) in
            if error == nil {
                if self.page == 1 {
                    self.schedule = schedules

                } else {
                    self.schedule.append(contentsOf: schedules)
                }
                
                self.view?.updateModel(schedules: self.schedule)
                if schedules.isEmpty {
                    self.view?.endLoadMore()
                }
                
                } else {
                if let error = ((error as? MoyaError)?.errorUserInfo["NSUnderlyingError"] as? Alamofire.AFError)?.underlyingError as NSError?,
                    error.domain == NSURLErrorDomain,
                    error.code == NSURLErrorNotConnectedToInternet
                        || error.code == NSURLErrorTimedOut
                        || error.code == NSURLErrorNetworkConnectionLost {
                    
                    self.view?.displayToast(isInternetConnectionError: true)
                } else {
                    self.view?.displayToast(isInternetConnectionError: false)
                }

                }
            }
        }
    }
}
