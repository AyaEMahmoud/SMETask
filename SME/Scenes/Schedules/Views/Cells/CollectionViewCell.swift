//
//  CollectionViewCell.swift
//  SME
//
//  Created by Aya Essam on 28/12/2020.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var cellView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        timeLabel.font = UIFont(font: FontFamily._29LTAzer.regular, size: 13)
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor(asset: Asset.Colors.steelBlue)?.cgColor
        cellView.layer.cornerRadius = 12
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

            timeLabel.text = "\(date12)"
        }
    }
    
    func setCellCompaniesData(company: Companies) {
        timeLabel.text = company.name
    }
    
    func setCellProjectsData(project: Projects) {
        timeLabel.text = project.name
    }
    
    func setCellOrganizationsData(text: String) {
        timeLabel.text = text
    }
    
    func setCellCommunicationData(communication: Int) {
        if communication == 1 {
            timeLabel.text = "آونلاين"
        } else {
            timeLabel.text = "في مكان"
        }
    }
}
