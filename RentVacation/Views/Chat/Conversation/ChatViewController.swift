//
//  ChatViewController.swift
//  RentVacation
//
//  Created by Vera Svet on 2/26/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit


final class ChatViewController: UIViewController {
    

    let dataSource = Array(repeating: MessageModel(author: "John Doe",
                                                    message: "Hello there"),
                           count: 10)
    
    static var identifier: String {
        return String(describing: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        let bundle = Bundle.init(for: MessageCell.self)
//        let nib = UINib(nibName: "MessageCell", bundle: bundle)
//        collectionView.register(nib,
//                                forCellWithReuseIdentifier: "messageCell")
    }
    

      
}


extension ChatViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "messageCell", for: indexPath)
        guard let chatListCell = cell as? MessageCell else { return UICollectionViewCell() }
        
        chatListCell.authorLabel.text = dataSource[indexPath.row].author;
        chatListCell.messageLabel.text = dataSource[indexPath.row].message;
        
        return chatListCell
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }
    
}

