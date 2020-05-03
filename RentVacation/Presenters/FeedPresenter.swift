//
//  FeedPresenter.swift
//  RentVacation
//
//  Created by Vera Svet on 5/3/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import Foundation

class FeedPresenter {
    private let feedService: FeedService
    weak private var feedViewDelegate: FeedViewDelegate?
    
    init(feedService: FeedService) {
        self.feedService = feedService
    }
    
    func setViewDelegate(feedViewDelegate: FeedViewDelegate) {
        self.feedViewDelegate = feedViewDelegate
    }
    
    func feedDataFetch() {
        var dataSource: Array<FeedCellModel> = Array()
        let _ = self.feedService.fetchData()
            .subscribe {event in
                var homeList: HomeList
                switch event {
                    case .next(let value):
                        homeList = value
                        for element in homeList.list {
                            let cell = FeedCellModel(description: element.description, imageUrl: element.image)
                            dataSource.append(cell)
                        }
                    case .error(let error):
                        print(error)
                    case .completed:
                        self.feedViewDelegate?.displayFeed(dataSource: dataSource)
                        print("completed")
                    }
                }
    }
}
