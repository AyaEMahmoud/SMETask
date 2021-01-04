//
//  ReservationViewController.swift
//  SME
//
//  Created by Aya Essam on 28/12/2020.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit

class ReservationViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {


    @IBOutlet private weak var textField: UITextField!
    @IBOutlet private weak var projectsView: UIView!
    @IBOutlet private weak var companiesView: UIView!
    @IBOutlet private weak var organizationView: UIView!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var officeNumLabel: UILabel!
    @IBOutlet private weak var wayOfCommunicationCollectionView: UICollectionView!
    @IBOutlet private weak var projectsCollectionView: UICollectionView!
    @IBOutlet private weak var companiesCollectionView: UICollectionView!
    @IBOutlet private weak var organizationCollectionView: UICollectionView!
    @IBOutlet private weak var wayOfCommunicationLabel: UILabel!
    @IBOutlet private weak var chooseProjectLabel: UILabel!
    @IBOutlet private weak var chooseCompanyLabel: UILabel!
    @IBOutlet private weak var chooseOrganizationLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var timeCollectionView: UICollectionView!
    @IBOutlet private weak var ksaTimeLabel: UILabel!
    @IBOutlet private weak var chooseTimeLabel: UILabel!
    @IBOutlet private weak var enterLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var reserveDateLabel: UILabel!
    
    var coordinator: MainCoordinator?

    lazy var companyPresenter = CompanyPresenter(with: self)
    lazy var projectPresenter = ProjectPresenter(with: self)
    lazy var reservePresenter = ReserveSlotPresenter(with: self)
    var companies = [Companies]()
    var projects = [Projects]()
    var schedule = [Schedules]()
    var organizations: [String] = ["Company", "Project"]
    var wayOfCommunication = 0
    var requestDictionary: [String: Any] = [:]
    var scheduleID: String = ""
    var date: String = ""
    var selectedIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabelFonts()
        textField.delegate = self
        companyPresenter.getUserCompanies()
        projectPresenter.getUserProjects()
        wayOfCommunication = schedule[0].communicationWay ?? 0
        setupCollectionView(collectionView: timeCollectionView)
        setupCollectionView(collectionView: organizationCollectionView)
        setupCollectionView(collectionView: companiesCollectionView)
        setupCollectionView(collectionView: projectsCollectionView)
        setupCollectionView(collectionView: wayOfCommunicationCollectionView)

        // Do any additional setup after loading the view.
    }
    
    func setupCollectionView(collectionView: UICollectionView) {
        collectionView.register(UINib(nibName: "CollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.semanticContentAttribute = .forceRightToLeft
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.timeCollectionView {
            return schedule.count
        } else if collectionView == self.companiesCollectionView {
            return companies.count
        } else if collectionView == self.projectsCollectionView {
            return projects.count
        } else if collectionView == self.organizationCollectionView {
            return organizations.count
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",
                                                      for: indexPath as IndexPath) as? CollectionViewCell

        if collectionView == self.timeCollectionView {
            
            if !schedule.isEmpty {
                let scheduleTime = schedule[indexPath.row]
                cell?.setCellData(time: scheduleTime)
            }
        } else if collectionView == self.companiesCollectionView {
            if !companies.isEmpty {
                let company = companies[indexPath.row]
                cell?.setCellCompaniesData(company: company)
            }
        } else if collectionView == self.projectsCollectionView {
            if !projects.isEmpty {
                let project = projects[indexPath.row]
                cell?.setCellProjectsData(project: project)
            }
        } else if collectionView == self.wayOfCommunicationCollectionView {
            let communication = wayOfCommunication
            cell?.setCellCommunicationData(communication: communication)
            cell?.contentView.backgroundColor = UIColor(asset: Asset.Colors.seaBlue)
        } else {
            if !organizations.isEmpty {
                let org = organizations[indexPath.row]
                cell?.setCellOrganizationsData(text: org)
            }
        }
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 101, height: 32)
      }

    @IBAction func okButtonTapped(_ sender: UIButton) {
        requestDictionary["purpose"] = textField.text
        print("request \(requestDictionary)")
        reservePresenter.reserveSlot(dictionaryRequest: requestDictionary)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.timeCollectionView {
            
            for cell in collectionView.visibleCells {
                cell.contentView.backgroundColor = .white
            }

            let selectedCell = collectionView.cellForItem(at: indexPath)
            selectedCell?.contentView.backgroundColor = UIColor(asset: Asset.Colors.seaBlue)
            
            wayOfCommunication = schedule[indexPath.row].communicationWay ?? 0
            requestDictionary["type"] = wayOfCommunication
            scheduleID = schedule[indexPath.row].id ?? ""
            self.wayOfCommunicationCollectionView.reloadData()
        }
        
        if collectionView == self.organizationCollectionView {
            
            for cell in collectionView.visibleCells {
                cell.contentView.backgroundColor = .white
            }
            
            let selectedCell = collectionView.cellForItem(at: indexPath)
            selectedCell?.contentView.backgroundColor = UIColor(asset: Asset.Colors.seaBlue)
            if organizations[indexPath.row] == "Company" {
            self.projectsView.isHidden = true
            self.companiesView.isHidden = false
            } else {
                self.projectsView.isHidden = false
                self.companiesView.isHidden = true
            }
            selectedIndex = indexPath.row
       }
        
        if collectionView == self.companiesCollectionView {
            for cell in collectionView.visibleCells {
                cell.contentView.backgroundColor = .white
            }
            
            let selectedCell = collectionView.cellForItem(at: indexPath)
            selectedCell?.contentView.backgroundColor = UIColor(asset: Asset.Colors.seaBlue)
            requestDictionary["company_id"] = companies[indexPath.row].id
            selectedIndex = indexPath.row
       }
        
       if collectionView == self.projectsCollectionView {
        
        for cell in collectionView.visibleCells {
            cell.contentView.backgroundColor = .white
            
        }
            let selectedCell = collectionView.cellForItem(at: indexPath)
            selectedCell?.contentView.backgroundColor = UIColor(asset: Asset.Colors.seaBlue)
            requestDictionary["project_id"] = projects[indexPath.row].id
       }
        
    }
    
    func setupLabelFonts() {
        reserveDateLabel.font = UIFont(font: FontFamily._29LTAzer.bold, size: 22)
        dateLabel.font = UIFont(font: FontFamily._29LTAzer.regular, size: 17)
        dateLabel.text = date
        enterLabel.font = UIFont(font: FontFamily._29LTAzer.medium, size: 16)
        chooseTimeLabel.font = UIFont(font: FontFamily._29LTAzer.medium, size: 16)
        ksaTimeLabel.font = UIFont(font: FontFamily._29LTAzer.regular, size: 16)
        chooseOrganizationLabel.font = UIFont(font: FontFamily._29LTAzer.medium, size: 16)
        chooseCompanyLabel.font = UIFont(font: FontFamily._29LTAzer.medium, size: 16)
        chooseProjectLabel.font = UIFont(font: FontFamily._29LTAzer.medium, size: 16)
        wayOfCommunicationLabel.font = UIFont(font: FontFamily._29LTAzer.medium, size: 16)
        officeNumLabel.font = UIFont(font: FontFamily._29LTAzer.regular, size: 15)
        submitButton.titleLabel?.font = UIFont(font: FontFamily._29LTAzer.bold, size: 17)

    }
}


extension ReservationViewController: ProjectPresenterView {
    
    func updateProjectsModel(projects: [Projects]) {
        if !projects.isEmpty {
            self.projects = projects
            self.projectsCollectionView.reloadData()
//            self.organizations.append("Project")
            self.organizationCollectionView.reloadData()

        } else {
            self.projectsView.isHidden = true
        }

    }
    
    func displayToast(isInternetConnectionError: Bool) {
        if isInternetConnectionError {
            self.view.makeToast("The Internet connection appears to be offline!", duration: 3.0, position: .bottom)
        } else {
            self.view.makeToast("Something went wrong!", duration: 3.0, position: .bottom)
        }
    }
}

extension ReservationViewController: CompanyPresenterView {
    
    func updateCompaniesModel(companies: [Companies]) {
        if !companies.isEmpty {
            print("in companies \(companies)")
            self.companies = companies
            self.companiesCollectionView.reloadData()
//            self.organizations.append("Company")
            self.organizationCollectionView.reloadData()
        } else {
            self.companiesView.isHidden = true
        }
    }
    
    func displayErrorToast(isInternetConnectionError: Bool) {
        if isInternetConnectionError {
            self.view.makeToast("The Internet connection appears to be offline!", duration: 3.0, position: .bottom)
        } else {
            self.view.makeToast("Something went wrong!", duration: 3.0, position: .bottom)
        }
    }
}

extension ReservationViewController: ReserveSlotView {
    func displaySuccessToast() {
        self.view.makeToast("Slot reserved successfully!", duration: 3.0, position: .bottom)
    }
}

extension ReservationViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.textField {
            if textField.hasText {
                submitButton.isEnabled = true
            } else {
                submitButton.isEnabled = false
            }
        }
    }
}
