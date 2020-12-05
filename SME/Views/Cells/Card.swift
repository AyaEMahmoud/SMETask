//
//  Card.swift
//  Monsh2atTask
//
//  Created by Aya Essam on 11/29/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit

class Card: UICollectionViewCell {
    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet weak var cardRating: UIView!
    @IBOutlet weak var activeStatus: UILabel!
    @IBOutlet weak var cardInfo: UILabel!
    @IBOutlet weak var cardName: UILabel!
    @IBOutlet weak var activeStatusIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 6
        imageView.layer.cornerRadius = 16
        cardView.layer.cornerRadius = 16
        
    }
    
//    func setCellData(profile: Profiles) {
//        self.activeStatus
//    }
    
}
