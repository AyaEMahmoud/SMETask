//
//  MainCoordinator.swift
//  SME
//
//  Created by Aya Essam on 28/12/2020.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import Foundation
import UIKit
import FittedSheets

class MainCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CardViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func viewSchedules(profile: Profiles) {
        let vc = ScheduleViewController()
        let tableVC = BottomViewController()
        vc.coordinator = self
        vc.profile = profile
        tableVC.contributerId = profile.id
        navigationController.pushViewController(vc, animated: true)
    }
    
    func viewReservation() {

    }
    
    func pop(viewController: UIViewController) {
        navigationController.popToViewController(viewController, animated: true)
    }
}
