//
//  FeedService.swift
//  RentVacation
//
//  Created by Vera Svet on 5/3/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

class FeedService {
    let request = RequestService()
    var dataSource: [FeedCellModel] = Array()
    let basePath = "http://localhost:4000/homeList"
    
    func fetchData() -> (Observable<HomeList>){
        let url = URL(string: basePath)
        let urlRequest = URLRequest(url: url!);
        let subscription: Observable<HomeList> = request.get(urlRequest).observeOn(MainScheduler.instance);
        return subscription;
    }
}
