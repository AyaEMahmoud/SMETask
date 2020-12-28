//
//  TableViewCell.swift
//  SME
//
//  Created by Aya Essam on 28/12/2020.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var dateLable: UILabel!
    @IBOutlet private weak var reservationButton: UIButton!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellView.layer.cornerRadius = 16
        reservationButton.layer.cornerRadius = 17.5
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    @IBAction func reserveAction(_ sender: UIButton) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 58.0, height: 24.0)
      }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath as IndexPath) as? CollectionViewCell
        return cell!
    }

    func setCellData(schedule: Schedules) {
        
//        dateLable.text = schedule.startTime
//        cardName.font = UIFont(font: FontFamily._29LTAzer.medium, size: 19.98)
//        
//        if profile.isAvailable ?? false {
//            unAvaliable.isHidden = true
//            activeStatus.font = UIFont(font: FontFamily._29LTAzer.medium, size: 15.9)
//        } else {
//            activeStatus.isHidden = true
//            unAvaliable.font = UIFont(font: FontFamily._29LTAzer.medium, size: 15.9)
//        }
//        if !(profile.isOnline ?? false) {
//            activeStatusIcon.isHidden = true
//        }
//        cardInfo.text = profile.subject?.title
//        cardInfo.font = UIFont(font: FontFamily._29LTAzer.regular, size: 13.9)
//        cosmosView.rating = profile.rating ?? 0
//        cosmosView.text = String(format: "%.1f", profile.rating ?? 0)
//                  
//        if let imageString = profile.file?.path, let url = URL(string: APPURL.StorageURL + imageString) {
//            imageView.kf.setImage(with: url)
//        } else {
//            imageView.image = nil
//        }
//        
        
    }
}
