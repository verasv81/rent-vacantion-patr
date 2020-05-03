//
//  FeedViewDelegate.swift
//  RentVacation
//
//  Created by Vera Svet on 5/3/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import Foundation

protocol FeedViewDelegate: NSObjectProtocol {
    func displayFeed(dataSource:([FeedCellModel]))
}
