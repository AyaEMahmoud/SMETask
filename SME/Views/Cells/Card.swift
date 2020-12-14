//
//  Card.swift
//  Monsh2atTask
//
//  Created by Aya Essam on 11/29/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit
import Cosmos
import Kingfisher

class Card: UICollectionViewCell {
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var unAvaliable: UILabel!
    @IBOutlet private weak var cosmosView: CosmosView!
    @IBOutlet private weak var activeStatus: UILabel!
    @IBOutlet private weak var cardInfo: UILabel!
    @IBOutlet private weak var cardName: UILabel!
    @IBOutlet private weak var activeStatusIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 6
        imageView.layer.borderColor = UIColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1)
            .cgColor
        imageView.layer.cornerRadius = 16
        cardView.layer.cornerRadius = 16
    }
    
    func setCellData(profile: Profiles) {
        
        cardName.text = profile.ssoUser?.fullName
        cardName.font = UIFont(font: FontFamily._29LTAzer.medium, size: 19.98)
        
        if profile.isAvailable ?? false {
            unAvaliable.isHidden = true
            activeStatus.font = UIFont(font: FontFamily._29LTAzer.medium, size: 15.9)
        } else {
            activeStatus.isHidden = true
            unAvaliable.font = UIFont(font: FontFamily._29LTAzer.medium, size: 15.9)
        }
        if !(profile.isOnline ?? false) {
            activeStatusIcon.isHidden = true
        }
        cardInfo.text = profile.subject?.title
        cardInfo.font = UIFont(font: FontFamily._29LTAzer.regular, size: 13.9)
        cosmosView.rating = profile.rating ?? 0
        cosmosView.text = String(format: "%.1f", profile.rating ?? 0)
                  
        if profile.file?.path != nil {
            let url = URL(string: APPURL.StorageURL + (profile.file?.path)!)
            imageView.kf.setImage(with: url)
        }
        
    }
    
}
