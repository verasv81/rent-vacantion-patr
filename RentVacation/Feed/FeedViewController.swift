//
//  FeedControllerViewController.swift
//  RentVacation
//
//  Created by Vera Svet on 2/17/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
struct Result: Codable {
    var args: String
    var headers: String
    var origin: String
    var url: String
}

class FeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = Array(repeating: FeedCellModel(description: "Lorem ipsum",
                                                    image: UIImage(named: "plant.png")!),
                              count: 30)
       
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let bundle = Bundle.init(for: FeedCell.self)
        let nib = UINib(nibName: "FeedCell", bundle: bundle)
        collectionView.register(nib,
                                forCellWithReuseIdentifier: "feedCell")
        
        let request = RequestService();
        let url = URL(string: "https://httpbin.org/get")
        let urlR = URLRequest(url: url!);
        let subscription: Observable<Result> = request.get(urlR).observeOn(MainScheduler.instance);
        let _ = subscription.subscribe {event in
            debugPrint(event)
        }
        
    }
   
}

extension FeedViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "feedCell", for: indexPath)
        guard let chatListCell = cell as? FeedCell else { return UICollectionViewCell() }
        
        chatListCell.descriptionLabel.text = dataSource[indexPath.row].description
        chatListCell.imageView.image = dataSource[indexPath.row].image
        
        return chatListCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 330)
    }
}
