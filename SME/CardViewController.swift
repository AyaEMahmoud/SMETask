//
//  CardViewController.swift
//  Monsh2atTask
//
//  Created by Aya Essam on 12/1/20.
//  Copyright © 2020 Aya E Mahmoud. All rights reserved.
//

import UIKit
import Kingfisher
import PullToRefreshKit
import Windless
import Network

class CardViewController: UIViewController {

    @IBOutlet private weak var bannerTopView: UIView!
    @IBOutlet private weak var bannerBottomView: UIView!
    @IBOutlet private weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView!

    var profiles = [Profiles]()
    var page = 1
    var windelssCount = 10;
    let monitor = NWPathMonitor()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.addObserver(self,
                                        forKeyPath: "contentSize",
                                        options: .new,
                                        context: nil)
        
//        let gradient = CAGradientLayer()
//        gradient.frame = bannerTopView.bounds
//        gradient.colors = [Asset.Colors.seaBlue, Asset.Colors.pacificBlue]
//        bannerTopView.layer.insertSublayer(gradient, at: 0)
//        bannerBottomView.layer.insertSublayer(gradient, at: 0)

        registerCell()
        inputTextFieldStyle()
        gradient()
//        startWindless()
//        initLoadMore()
//        getProfiles()
    }

    func gradient() {
         let gradientLayer: CAGradientLayer = CAGradientLayer()
         gradientLayer.frame.size = self.bannerTopView.frame.size
         gradientLayer.colors = [Asset.Colors.pacificBlue, Asset.Colors.seaBlue]
         gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
         gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
         bannerTopView.layer.addSublayer(gradientLayer)
    }
    
    fileprivate func inputTextFieldStyle() {
        bannerBottomView.layer.masksToBounds = true
        bannerBottomView.layer.borderWidth = 1
        bannerBottomView.layer.cornerRadius = 20
        bannerBottomView.layer.maskedCorners = [.layerMaxXMaxYCorner]
    }
    
    func registerCell() {
        collectionView.register(UINib(nibName: "Card", bundle: nil), forCellWithReuseIdentifier: "Card")
      }
   
    func initLoadMore() {
         self.collectionView.configRefreshFooter(container: self) {
             self.page += 1
             self.getProfiles()
         }
     }
    
    func initPullToRefresh() {
           self.collectionView.configRefreshHeader(container: self) {
               self.page = 1
               self.getProfiles()
           }
       }
     func startWindless() {
         self.collectionView.windless
             .apply {
                 $0.beginTime = 0
                 $0.pauseDuration = 1
                 $0.duration = 1.5
                 $0.animationLayerOpacity = 0.8
             }
             .start()
     }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey: Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        if (keyPath == "contentSize"),
            let newvalue = change?[.newKey],
            let newsize = newvalue as? CGSize {
            
            if newsize.height == 0 {
                self.collectionViewHeightConstraint.constant = 752
                self.containerViewHeightConstraint.constant = 761
            } else if self.collectionViewHeightConstraint.constant != newsize.height {
                self.collectionViewHeightConstraint.constant = newsize.height
                self.containerViewHeightConstraint.constant = newsize.height + 9

            }
            
        }
        
    }
    
    deinit {
           self.collectionView.removeObserver(self, forKeyPath: "contentSize")
       }
    
    func getProfiles() {
         let profilesRequest = ProfilesRequest(byParameter: "نافذة الاستفسارات العامة", page: page)
         networkManager.getProfiles(profilesRequest: profilesRequest) { (profiles, error) in
             self.collectionView.switchRefreshFooter(to: .normal)
             self.collectionView.switchRefreshHeader(to: .normal(.success, 0.0))
             self.collectionView.windless.end()
             self.windelssCount = 0

            print("error \(error)")
            if error == nil {
                 if self.page == 1 {
                    self.profiles = profiles

                 } else {
                    self.profiles.append(contentsOf: profiles)
                 }
                 self.collectionView.reloadData()
             } else {
                 let alert = UIAlertController(title: "", message: "Nothing to show!", preferredStyle: .alert)
                 let action = UIAlertAction(title: "OK", style: .default, handler: { _ in
                 })
                 alert.addAction(action)
                 self.present(alert, animated: true, completion: nil)

             }
         }
     }
}

extension CardViewController: UICollectionViewDelegate {
    
}

extension CardViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        print("profiles.isEmpty \(profiles.count)")
//        return profiles.count
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath as IndexPath) as? Card
        
        print("profiles.isEmpty \(profiles.isEmpty)")
        
        if !profiles.isEmpty {
            let card = profiles[indexPath.row]
            cell?.cardName.text = card.ssoUser?.fullName
            if !(card.isAvailable ?? false) {
                cell?.activeStatus.isHidden = true
            }
            if !(card.isOnline ?? false) {
                cell?.activeStatusIcon.isHidden = true
            }
            cell?.cardInfo.text = card.subject?.title
//            cell?.cardRating.
//            if let imageString = movie.posterPath, let url = URL(string: APPURL.BaseURL + imageString) {
//                print("url \(url)")
//                cell?.movieImage.kf.setImage(with: url)
//            }
        }
        
        return cell!
    }
    
}

extension CardViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath)
        -> CGSize {
        return CGSize(width: 160.81, height: 219.73)
    }
}
