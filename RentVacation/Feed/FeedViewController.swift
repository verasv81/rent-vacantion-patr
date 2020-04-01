//
//  FeedControllerViewController.swift
//  RentVacation
//
//  Created by Vera Svet on 2/17/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit
import RxSwift

class FeedViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var refreshBtn: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBAction func addHome(_ sender: Any) {
        self.showModal()
    }
    
    @IBAction func onClick(_ sender: Any) {
        self.fetchData()
        self.collectionView.reloadData()
    }
    
    var dataSource: Array<FeedCellModel> = Array()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bundle = Bundle.init(for: FeedCell.self)
        let nib = UINib(nibName: "FeedCell", bundle: bundle)
        collectionView.register(nib,
                                forCellWithReuseIdentifier: "feedCell")
        fetchData()
    }
    
    private func fetchData() {
        let request = RequestService()
        let url = URL(string: "http://localhost:4000/homeList")
        let urlRequest = URLRequest(url: url!);
        let subscription: Observable<HomeList> = request.get(urlRequest).observeOn(MainScheduler.instance);
        
        let _ = subscription.subscribe{ event in
            var homeList : HomeList;
            switch event {
            case .next(let value):
                homeList = value
                for element in homeList.list {
                    let url = URL(string: element.image)
                    let data = try? Data(contentsOf: url!)
                    let cell = FeedCellModel(description: element.description, image: UIImage(data: data!) ?? UIImage(imageLiteralResourceName: "plant.png"))
                    self.dataSource.append(cell)
                }
            case .error(let error):
                print(error)
            case .completed:
                self.collectionView.reloadData()
                print("completed")
            }
        }
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
        chatListCell.imageView.image = dataSource[indexPath.row].image
        
        return chatListCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 330)
    }
}
