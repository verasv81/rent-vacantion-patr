//
//  FeedCellModel.swift
//  RentVacation
//
//  Created by Vera Svet on 2/27/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit

final class FeedCellModel {
    let description: String
    let imageUrl: String
    
    init(description: String, imageUrl: String) {
        self.description = description;
        self.imageUrl = imageUrl;
    }
}
