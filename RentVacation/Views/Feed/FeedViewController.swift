//
//  FeedControllerViewController.swift
//  RentVacation
//
//  Created by Vera Svet on 2/17/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit
import RxSwift

class FeedViewController: UIViewController, FeedViewDelegate {
    private let feedPresenter = FeedPresenter(feedService: FeedService())
    var dataSource: Array<FeedCellModel> = Array()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.feedPresenter.setViewDelegate(feedViewDelegate: self)
        
        let bundle = Bundle.init(for: FeedCell.self)
        let nib = UINib(nibName: "FeedCell", bundle: bundle)
        collectionView.register(nib,
                                forCellWithReuseIdentifier: "feedCell")
        self.feedPresenter.feedDataFetch()
    }
    
    func displayFeed(dataSource: ([FeedCellModel])) {
        self.dataSource = dataSource
        self.collectionView.reloadData()
    }
    
    @IBAction func addHome(_ sender: Any) {
        self.showModal()
    }
    
    @IBAction func onClick(_ sender: Any) {
        self.feedPresenter.feedDataFetch()
        self.collectionView.reloadData()
    }
    
    private func showModal() {
        let modalViewController = ModalViewController()
        modalViewController.modalPresentationStyle = .pageSheet
        present(modalViewController, animated: true, completion: nil)
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
        let url = URL(string: dataSource[indexPath.row].imageUrl)
        let data = try? Data(contentsOf: url!)
        chatListCell.imageView.image = UIImage(data: data!)
        
        return chatListCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 330)
    }
}
