//
//  BottomPageDelegate.swift
//  TwitterProfile
//
//  Created by OfTheWolf on 08/18/2019.
//  Copyright (c) 2019 OfTheWolf. All rights reserved.
//
//swiftlint:disable all
import UIKit

public protocol BottomPageDelegate {
    func tp_pageViewController(_ currentViewController: UIViewController?, didSelectPageAt index: Int)
}
