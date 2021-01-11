//
//  TPProgressDelegate.swift
//  TwitterProfile
//
//  Created by OfTheWolf on 08/18/2019.
//  Copyright (c) 2019 OfTheWolf. All rights reserved.
//
//swiftlint:disable all
import UIKit

public protocol TPProgressDelegate {
    func tp_scrollView(_ scrollView: UIScrollView, didUpdate progress: CGFloat)
    func tp_scrollViewDidLoad(_ scrollView: UIScrollView)
    func tp_refreshController() -> UIRefreshControl
    func infiniteScrollTriggered(scroll:UIScrollView)
//    func scrollViewDidScrollToTop(_ scrollView: UIScrollView,)
}
