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
    func updateModel(schedulesData: [SchedulesData])
    func updateCollectionBackground()
    func displayToast(isInternetConnectionError: Bool)
    func endLoadMore()
}

class SchedulePresenter {
    
    weak var view: SchedulePresenterView?
    
    let networkManager = SchedulesService()
    var page = 1
    var schedulesData: [SchedulesData] = []
    
    init(with view: SchedulePresenterView) {
    self.view = view

    }
    
    func getSchedules(contributerId: String) {
        if !InternetChecker.isConnectedToNetwork() && page == 1 {
            self.view?.updateCollectionBackground()
        } else {
         
            networkManager.getSchedules(contributerId: contributerId) { (schedulesData, error) in
            if error == nil {
                if self.page == 1 {
                    self.schedulesData = schedulesData

                } else {
                    self.schedulesData.append(contentsOf: schedulesData)
                }
                
                self.view?.updateModel(schedulesData: self.schedulesData)
                if schedulesData.isEmpty {
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
