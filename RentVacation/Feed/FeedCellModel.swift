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
    let image: UIImage
    
    init(description: String, image: UIImage) {
        self.description = description;
        self.image = image;
    }
}
