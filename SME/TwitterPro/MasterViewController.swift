//
//  MasterViewController.swift
//  TwitterProfile
//
//  Created by OfTheWolf on 08/18/2019.
//  Copyright (c) 2019 OfTheWolf. All rights reserved.
//
//swiftlint:disable all
import UIKit


class MasterViewController : UIViewController, UIScrollViewDelegate {
    var scrollView: UIScrollView!
    var panViews: [Int: UIView] = [:]
    public var overlayScrollView: UIScrollView!
    public var yPosition: CGFloat = 0.0 {
        didSet {
//        NotificationCenter.default.post(name: .listenToScroll, object: nil)
        }
    }
    var currentIndex: Int = 0
    
    var pagerTabHeight: CGFloat = 44
    
    var dataSource: TPDataSource!
    var delegate: TPProgressDelegate?
    
    var headerView: UIView!
    
    var contentOffsets: [Int: CGFloat] = [:]
    
    @objc
    func stopScrolling() {
//        overlayScrollView.removeInfiniteScroll()
    }
    
    @objc
    func startScrolling() {
//        overlayScrollView.addInfiniteScroll { (scroll) in
//            print("overlayScrollView addInfiniteScroll")
//            self.delegate?.infiniteScrollTriggered(scroll: scroll)
//        }
    }
    override func loadView() {
        
//        NotificationCenter.default.addObserver(self, selector: #selector(stopScrolling),
//                                               name: .stopScrolling, object: nil)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(startScrolling),
//                                               name: .startScrolling, object: nil)
        
        scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        let f = UIScreen.main.bounds
        scrollView.frame = CGRect(x: f.minX, y: f.minY, width: f.width, height: f.height)
        scrollView.contentSize = CGSize.init(width: f.width, height: f.height + dataSource.headerHeight().upperBound)
        
        overlayScrollView = UIScrollView()
        overlayScrollView.showsVerticalScrollIndicator = false
        overlayScrollView.contentInset.bottom = 70
        overlayScrollView.backgroundColor = UIColor.clear
        overlayScrollView.frame = CGRect(x: f.minX, y: f.minY, width: f.width, height: f.height)
        overlayScrollView.contentSize = self.scrollView.contentSize
        
        let headerVC = dataSource.headerViewController()
        add(headerVC, to: scrollView, frame: CGRect(x: f.minX, y: 0, width: f.width, height: dataSource.headerHeight().upperBound))
        headerView = headerVC.view
        var bottomVC = dataSource.bottomViewController()
        bottomVC.pageDelegate = self
        self.pagerTabHeight = bottomVC.pagerTabHeight ?? 44
        
        add(bottomVC, to: scrollView, frame: CGRect(x: f.minX, y: dataSource.headerHeight().upperBound, width: f.width, height: f.height))
        if let vc = bottomVC.currentViewController{
            self.panViews[currentIndex] = vc.panView()
            if let scrollView = self.panViews[currentIndex] as? UIScrollView{
                scrollView.panGestureRecognizer.require(toFail: self.overlayScrollView.panGestureRecognizer)
                scrollView.donotAdjustContentInset()
            }
        }
        
        let view = UIView()
        view.addSubview(overlayScrollView)
        view.addSubview(scrollView)
        view.frame = UIScreen.main.bounds
        self.view = view
        
        scrollView.addGestureRecognizer(overlayScrollView.panGestureRecognizer)
        overlayScrollView.donotAdjustContentInset()
        scrollView.donotAdjustContentInset()
        
        overlayScrollView.layer.zPosition = 999
        // scrollView.refreshControl = delegate?.tp_refreshController()
        delegate?.tp_scrollViewDidLoad(overlayScrollView)
       
//        overlayScrollView.addInfiniteScroll { (scroll) in
//            print("overlayScrollView addInfiniteScroll")
//            self.delegate?.infiniteScrollTriggered(scroll: scroll)
//        }
        //scrollView.scrollsToTop = false
        // overlayScrollView.scrollsToTop = false
     
        
    }
func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {

overlayScrollView.contentOffset.y = -scrollView.contentInset.top

}
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let scrollView = self.panViews[currentIndex] as? UIScrollView{
            let bottomHeight = max(scrollView.contentSize.height, self.view.frame.height - dataSource.headerHeight().lowerBound)
            self.overlayScrollView.contentSize = CGSize.init(width: scrollView.contentSize.width, height: bottomHeight + dataSource.headerHeight().upperBound + pagerTabHeight + bottomInset)
            scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize), options: .new, context: nil)
        }else if let view = self.panViews[currentIndex]{
            let bottomHeight = self.view.frame.height - dataSource.headerHeight().lowerBound
            self.overlayScrollView.contentSize = CGSize.init(width: view.frame.width, height: bottomHeight + dataSource.headerHeight().upperBound + pagerTabHeight + bottomInset)
        }
          
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.delegate = self
        overlayScrollView.delegate = self
    }
    
    deinit {
        self.panViews.forEach({ (arg0) in
            let (_, value) = arg0
            if let scrollView = value as? UIScrollView{
                scrollView.removeObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize))
            }
        })
    }
    
    func getContentSize(for bottomView: UIView) -> CGSize{
        if let scroll = bottomView as? UIScrollView{
            let bottomHeight = max(scroll.contentSize.height, self.view.frame.height - dataSource.headerHeight().lowerBound - pagerTabHeight - bottomInset)
            return CGSize.init(width: scroll.contentSize.width, height: bottomHeight + dataSource.headerHeight().upperBound + pagerTabHeight + bottomInset)
        }else{
            let bottomHeight = self.view.frame.height - dataSource.headerHeight().lowerBound - pagerTabHeight
            return CGSize.init(width: bottomView.frame.width, height: bottomHeight + dataSource.headerHeight().upperBound + pagerTabHeight + bottomInset)
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let obj = object as? UIScrollView, let scroll = self.panViews[currentIndex] as? UIScrollView {
            if obj == scroll && keyPath == #keyPath(UIScrollView.contentSize) {
                self.overlayScrollView.contentSize = getContentSize(for: scroll)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        yPosition = scrollView.contentOffset.y
        contentOffsets[currentIndex] = scrollView.contentOffset.y
        let topHeight = dataSource.headerHeight().upperBound - dataSource.headerHeight().lowerBound
        
        if scrollView.contentOffset.y < topHeight{
            self.scrollView.contentOffset.y = scrollView.contentOffset.y
            self.panViews.forEach({ (arg0) in
                let (_, value) = arg0
                (value as? UIScrollView)?.contentOffset.y = 0
            })
            contentOffsets.removeAll()
        }else{
            self.scrollView.contentOffset.y = dataSource.headerHeight().upperBound - dataSource.headerHeight().lowerBound
            (self.panViews[currentIndex] as? UIScrollView)?.contentOffset.y = scrollView.contentOffset.y - self.scrollView.contentOffset.y
            
        }
        
        if scrollView.contentOffset.y < 0{
            headerView.frame = CGRect(x: headerView.frame.minX,
                                      y: min(topHeight, scrollView.contentOffset.y),
                                      width: headerView.frame.width,
                                      height: max(dataSource.headerHeight().lowerBound, dataSource.headerHeight().upperBound + -scrollView.contentOffset.y))
            
        }else{
            headerView.frame = CGRect(x: headerView.frame.minX,
                                      y: 0,
                                      width: headerView.frame.width,
                                      height: dataSource.headerHeight().upperBound)
        }
        
        let progress = self.scrollView.contentOffset.y / topHeight
        self.delegate?.tp_scrollView(self.scrollView, didUpdate: progress)
    }
}

//MARK: BottomPageDelegate
extension MasterViewController : BottomPageDelegate {
    
    func tp_pageViewController(_ currentViewController: UIViewController?, didSelectPageAt index: Int) {
        currentIndex = index
        
        if let offset = contentOffsets[index]{
            self.overlayScrollView.contentOffset.y = offset
        }else{
            self.overlayScrollView.contentOffset.y = self.scrollView.contentOffset.y
        }
        
        if let vc = currentViewController, self.panViews[currentIndex] == nil{
            self.panViews[currentIndex] = vc.panView()
            if let scrollView = self.panViews[currentIndex] as? UIScrollView{
                scrollView.panGestureRecognizer.require(toFail: self.overlayScrollView.panGestureRecognizer)
                scrollView.donotAdjustContentInset()
            }
        }
        
        if let scrollView = self.panViews[currentIndex] as? UIScrollView{
            self.overlayScrollView.contentSize = getContentSize(for: scrollView)
            scrollView.addObserver(self, forKeyPath: #keyPath(UIScrollView.contentSize), options: .new, context: nil)
        }else if let bottomView = self.panViews[currentIndex]{
            self.overlayScrollView.contentSize = getContentSize(for: bottomView)
        }
    }
    
}
