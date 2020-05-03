//
//  HomePresenter.swift
//  RentVacation
//
//  Created by Vera Svet on 5/3/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import Foundation

class HomePresenter {
    private let feedService: FeedService
    weak private var homeViewDelegate: HomeViewDelegate?
    
    init(feedService: FeedService) {
        self.feedService = feedService
    }
    
    func setViewDelegate(homeViewDelegate: HomeViewDelegate) {
        self.homeViewDelegate = homeViewDelegate
    }
    
    func addHome(title: String, description: String, imageUrl: String) {
        let _ = self.feedService.addHome(title: title, description: description, imageUrl: imageUrl)
            .subscribe {event in
                print(event)
                self.homeViewDelegate?.saveHome()
        }
    }
}
