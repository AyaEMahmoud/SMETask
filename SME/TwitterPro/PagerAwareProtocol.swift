//
//  PagerAwareProtocol.swift
//  TwitterProfile
//
//  Created by OfTheWolf on 08/18/2019.
//  Copyright (c) 2019 OfTheWolf. All rights reserved.
//
//swiftlint:disable all
import UIKit

public protocol PagerAwareProtocol {
    var pageDelegate: BottomPageDelegate? {get set}
    var currentViewController: UIViewController? {get}
    var pagerTabHeight: CGFloat? {get}
}
