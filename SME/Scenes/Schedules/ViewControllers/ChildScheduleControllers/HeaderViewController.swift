//
//  HeaderViewController.swift
//  TwitterProfile
//
//  Created by OfTheWolf on 08/18/2019.
//  Copyright (c) 2019 OfTheWolf. All rights reserved.
//

import UIKit
import Cosmos

class HeaderViewController: UIViewController {
    
    @IBOutlet weak var userRating: CosmosView!
    @IBOutlet weak var userInfo: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var coverImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var covermageView: UIImageView!
    @IBOutlet weak var pageLabel: UILabel!
    
    var animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: nil)

    var titleInitialCenterY: CGFloat!
    var covernitialCenterY: CGFloat!
    var covernitialHeight: CGFloat!
    var bannerInitialHeight: CGFloat!
    
    var stickyCover = true
    
    var viewDidLayoutOnce = false
    
    var profile: Profiles?
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.layer.cornerRadius = 12
        userImageView.layer.cornerRadius = 16
        userImageView.layer.borderWidth = 7
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderColor = UIColor(asset: Asset.Colors.timberwolf)?.cgColor
        
        if let profile = self.profile {
            userName.text = profile.ssoUser?.fullName
            userName.font = UIFont(font: FontFamily._29LTAzer.bold, size: 18)
            userInfo.text = profile.subject?.title
            userInfo.font = UIFont(font: FontFamily._29LTAzer.medium, size: 14)
            userRating.rating = profile.rating ?? 0
            userRating.text = String(format: "%.1f", profile.rating ?? 0)

            if let imageString = profile.file?.path, let url = URL(string: APPURL.StorageURL + imageString) {
                userImageView.kf.setImage(with: url)
            } else {
                userImageView.image = nil
            }
        }
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if !viewDidLayoutOnce{
            viewDidLayoutOnce = true
            covernitialCenterY = covermageView.center.y
            covernitialHeight = covermageView.frame.height
        }

    }
    
    @IBAction func readMoreAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3) {
        }
    }
    
    func update(with progress: CGFloat, headerHeight: ClosedRange<CGFloat>){

        let y = progress * (headerHeight.upperBound - headerHeight.lowerBound)
        let topLimit = covernitialHeight - headerHeight.lowerBound
      
        if y > 0 {
            covermageView.center.y = covermageView.bounds.height / 2 + y
        } else {
            covermageView.center.y = covermageView.bounds.height / 2
        }
        
        coverImageHeightConstraint.constant = max(covernitialHeight,
                                                  covernitialHeight - y)
                        
        if progress < 0 {
            animator.fractionComplete = abs(min(0, progress))
        }
        
        if y > topLimit {
            covermageView.center.y = covernitialCenterY + y - topLimit
            if stickyCover{
                self.stickyCover = false
                userImageView.layer.zPosition = 0
            }
        }else{
            covermageView.center.y = covernitialCenterY
            let scale = min(1, (1-progress*1.3))
            let t = CGAffineTransform(scaleX: scale, y: scale)
            userImageView.transform = t.translatedBy(x: 0, y: userImageView.frame.height*(1 - scale))

            if !stickyCover{
                self.stickyCover = true
            }
        }
        
//        if y > topLimit {
//            if stickyCover {
//                self.stickyCover = false
//                self.userImageView.layer.zPosition = 0
//            }
//        } else {
//            let scale = min(1, (1 - (progress * 1.3)))
//            let t = CGAffineTransform(scaleX: scale, y: scale)
//            userImageView.transform = t.translatedBy(x: 0, y: userImageView.frame.height * (1 - scale))
//            
//            if !stickyCover {
//                self.stickyCover = true
//                self.userImageView.layer.zPosition = 2
//            }
//        }
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        coordinator?.pop()
    }
    
}

extension HeaderViewController {
    
}
