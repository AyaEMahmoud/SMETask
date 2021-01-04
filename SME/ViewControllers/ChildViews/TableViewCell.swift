//
//  TableViewCell.swift
//  SME
//
//  Created by Aya Essam on 28/12/2020.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit
import FittedSheets

protocol ReservationProtocal {
    func loadReservationScreen(schedule: [Schedules])
}

class TableViewCell: UITableViewCell,
                     UICollectionViewDelegate,
                     UICollectionViewDataSource,
                     UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var dateLable: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var delegate: ReservationProtocal?
    var schedule = [Schedules]()

    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 12
        cellView.layer.borderColor = UIColor(red: 48, green: 132, blue: 178, alpha: 1).cgColor
        cellView.layer.borderWidth = 1

        dateLable.font = UIFont(font: FontFamily._29LTAzer.medium, size: 19)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionViewCell",
                                      bundle: nil),
                                forCellWithReuseIdentifier: "CollectionViewCell")
        self.collectionView.semanticContentAttribute = .forceRightToLeft
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return schedule.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    @IBAction func reserveTapped(_ sender: UIButton) {
        delegate?.loadReservationScreen(schedule: self.schedule)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 58, height: 24)
      }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell",
                                                      for: indexPath as IndexPath) as? CollectionViewCell
        
        if !schedule.isEmpty {
            let scheduleTime = schedule[indexPath.row]
            cell?.setCellData(time: scheduleTime)
        }
        return cell!
    }

    func setCellData(schedulesData: SchedulesData) {
        
        if let timeResult = (schedulesData.day as? Int) {
            dateLable.text = formateDateToArabic(timeResult: timeResult)
        }
    }
    
    func formateDateToArabic(timeResult: Int) -> String {
        
        let formatter = DateFormatter()
        let date = Date(timeIntervalSince1970: TimeInterval(timeResult))
        formatter.locale = NSLocale(localeIdentifier: "ar_DZ") as Locale
        formatter.dateFormat = "EEEE, d MMMM"
        let outputDate = formatter.string(from: date)
                
        return outputDate
    }
}
