//
//  ChatListViewController.swift
//  RentVacation
//
//  Created by Vera Svet on 2/20/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit

final class ChatListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataSource = Array(repeating: ChatListInteractor(author: "John Doe",
                                                    message: "Hello, I am very happy to see you.",
                                                    avatarUrl: "account.png"),
                           count: 30)
    
    static var identifier: String {
        return String(describing: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let bundle = Bundle.init(for: ChatListCell.self)
        let nib = UINib(nibName: "ChatListCell", bundle: bundle)
        collectionView.register(nib,
                                forCellWithReuseIdentifier: "chatListCell")
    }
    

      
}

extension ChatListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatListCell", for: indexPath)
        guard let chatListCell = cell as? ChatListCell else { return UICollectionViewCell() }
        
        chatListCell.authorLabel.text = dataSource[indexPath.row].author;
        chatListCell.messageLabel.text = dataSource[indexPath.row].message;
        chatListCell.avatarImage.image = UIImage(named: dataSource[indexPath.row].avatarUrl);
//        chatListCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        return chatListCell
    }
    
    @objc func tap(_ sender: UITapGestureRecognizer) {

       let location = sender.location(in: self.collectionView)
       let indexPath = self.collectionView.indexPathForItem(at: location)

       if let index = indexPath {
          print("Got clicked on index: \(index)!")
       }
        
//        let collectionVC = instantiateViewController(
//            storyboardName: "Chat",
//            identifier: ChatViewController.identifier,
//            type: ChatViewController.self
//        )
//        
//        navigationController?.pushViewController(collectionVC, animated: true)
    }
    
    private func instantiateViewController<T: UIViewController>(storyboardName: String,
                                                                identifier: String,
                                                                type: T.Type) -> T {
        let storyboard: UIStoryboard = UIStoryboard(
            name: storyboardName,
            bundle: Bundle(for: type)
        )

        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? T else {
            fatalError("Could not instantiate \(identifier) from storyboard file.")
        }

        viewController.modalPresentationStyle = .fullScreen

        return viewController
    }
}

extension ChatListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 125)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let collectionVC = instantiateViewController(
            storyboardName: "Chat",
            identifier: ChatViewController.identifier,
            type: ChatViewController.self
        )

        navigationController?.pushViewController(collectionVC, animated: true)
    }
}
