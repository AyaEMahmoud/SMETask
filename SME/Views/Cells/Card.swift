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
    
    @IBOutlet private weak var cardRating: UIView!
    @IBOutlet private weak var activeStatus: UILabel!
    @IBOutlet private weak var cardInfo: UILabel!
    @IBOutlet private weak var cardName: UILabel!
    @IBOutlet private weak var activeStatusIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 6
        imageView.layer.cornerRadius = 16
        cardView.layer.cornerRadius = 16
        
    }
    
}
