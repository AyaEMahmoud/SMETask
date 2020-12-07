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
import Reachability
import Cosmos

class CardViewController: UIViewController {

    @IBOutlet weak var bannerHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private weak var collectionView: UICollectionView!

    var profiles = [Profiles]()
    var page = 1
    var windelssCount = 10;
    
    let networkManager = ProfilesService()
    
    let reachability = try! Reachability()
    
    var maximumBannerHeight: CGFloat = 219
    var minimumBannerHeight: CGFloat = 145
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.collectionView.addObserver(self,
//                                        forKeyPath: "contentSize",
//                                        options: .new,
//                                        context: nil)
        registerCell()
//        startWindless()
//        initLoadMore()
        getProfiles()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reachabilityChanged(note:)),
                                               name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }

    @objc
    func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability

        switch reachability.connection {
        case .wifi:
            print("Wifi Connection")
        case .cellular:
            print("Cellular Connection")
        case .unavailable:
             print("no connection")
            self.collectionView.backgroundView = NoInternet()
        case .none:
            print("no connection")
        @unknown default:
            print("no connection")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
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
    
//    override func observeValue(forKeyPath keyPath: String?,
//                               of object: Any?,
//                               change: [NSKeyValueChangeKey: Any]?,
//                               context: UnsafeMutableRawPointer?) {
//
//        if (keyPath == "contentSize"),
//            let newvalue = change?[.newKey],
//            let newsize = newvalue as? CGSize {
//
//            if newsize.height == 0 {
//                self.collectionViewHeightConstraint.constant = 752
//            } else if self.collectionViewHeightConstraint.constant != newsize.height {
//                self.collectionViewHeightConstraint.constant = newsize.height
//
//            }
//
//        }
//
//    }
    
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
        return profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Card", for: indexPath as IndexPath) as? Card
        
        print("profiles.isEmpty \(profiles.isEmpty)")
        
        if !profiles.isEmpty {
            let card = profiles[indexPath.row]
            cell?.cardName.text = card.ssoUser?.fullName
            if card.isAvailable ?? false {
                cell?.unAvaliable.isHidden = true
            } else {
                cell?.activeStatus.isHidden = true
            }
            if !(card.isOnline ?? false) {
                cell?.activeStatusIcon.isHidden = true
            }
            cell?.cardInfo.text = card.subject?.title
            
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

extension CardViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offset = scrollView.contentOffset;
//        if offset.y < minimumBannerHeight {
//            bannerHeightConstraint.constant = maximumBannerHeight - offset.y
//        }
        let offset: CGFloat = scrollView.contentOffset.y
        let newHeaderViewHeight: CGFloat = bannerHeightConstraint.constant - offset

        if newHeaderViewHeight > maximumBannerHeight {
            bannerHeightConstraint.constant = maximumBannerHeight
        } else if newHeaderViewHeight < minimumBannerHeight {
            bannerHeightConstraint.constant = minimumBannerHeight
        } else {
            bannerHeightConstraint.constant = newHeaderViewHeight
            scrollView.contentOffset.y = 0 // block scroll view
        }
    }
}
