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
    let basePath = "http://localhost:4000"
    
    func fetchData() -> (Observable<HomeList>){
        let path = self.basePath + "/homeList"
        let url = URL(string: path)
        let urlRequest = URLRequest(url: url!);
        let subscription: Observable<HomeList> = request.get(urlRequest).observeOn(MainScheduler.instance);
        return subscription;
    }
    
    func addHome(title: String, description: String, imageUrl: String) -> Observable<Success> {
        let home = Home(
            title: title,
            description: description,
            image: imageUrl)
        
        let url = self.basePath + "/home"
        let subscription: Observable<Success> = request.post(url, parameters: home).observeOn(MainScheduler.instance)
        
        return subscription
    }
}
