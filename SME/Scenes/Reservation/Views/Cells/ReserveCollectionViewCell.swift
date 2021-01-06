//
//  ReserveCollectionViewCell.swift
//  SME
//
//  Created by Aya Essam on 04/01/2021.
//  Copyright © 2021 Aya E Mahmoud. All rights reserved.
//

import UIKit

class ReserveCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet private weak var cellContentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellLabel.font = UIFont(font: FontFamily._29LTAzer.medium, size: 14)

    }
    
    func setCellData(time: Schedules) {
       
        if let timeResult = (time.startTime) {
            let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let time = "\(hour):\(minutes)"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let date24 = dateFormatter.date(from: time)
            
            dateFormatter.dateFormat = "h:mm a"
            let date12 = dateFormatter.string(from: date24!)

            cellLabel.text = "\(date12)"
        }
    }
    
    func setCellCompaniesData(company: Companies) {
        cellLabel.text = company.name
    }
    
    func setCellProjectsData(project: Projects) {
        cellLabel.text = project.name
    }
    
    func setCellOrganizationsData(text: String) {
        cellLabel.text = text
    }
    
    func setCellCommunicationData(communication: Int) {
        if communication == 1 {
            cellLabel.text = "آونلاين"
        } else {
            cellLabel.text = "في مكان"
        }
    }
}
