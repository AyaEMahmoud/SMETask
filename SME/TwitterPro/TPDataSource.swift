//
//  TPDataSource.swift
//  TwitterProfile
//
//  Created by OfTheWolf on 08/18/2019.
//  Copyright (c) 2019 OfTheWolf. All rights reserved.
//
//swiftlint:disable all
import UIKit

public protocol TPDataSource {
    func headerViewController() -> UIViewController
    func bottomViewController() -> UIViewController & PagerAwareProtocol
    func headerHeight() -> ClosedRange<CGFloat>
}
