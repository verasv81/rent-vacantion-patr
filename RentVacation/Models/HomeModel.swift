//
//  HomeModel.swift
//  RentVacation
//
//  Created by Vera Svet on 4/1/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

struct Home: Codable {
    var title: String
    var description: String
    var image: String
}

struct HomeList: Codable {
    let list: [Home]
}

struct Success: Codable {
    let success: String
}
