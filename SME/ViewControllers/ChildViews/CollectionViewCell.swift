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
    }
    
    func setCellData(time: Schedules) {
       
        if let timeResult = (time.startTime as? Int) {
            let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            timeLabel.text = "\(hour):\(minutes) AM"
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
}
