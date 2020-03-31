//
//  CommentViewController.swift
//  RentVacation
//
//  Created by Vera Svet on 2/27/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit

final class CommentViewController: UIViewController {
    
    
    let dataSource = Array(repeating: CommentModel(author: "John Doe",
                                                    message: "Hello, I am very happy to see you."),
                           count: 30)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let bundle = Bundle.init(for: CommentCell.self)
//        let nib = UINib(nibName: "CommentCell", bundle: bundle)
//        collectionView.register(nib,
//                                forCellWithReuseIdentifier: "commentCell")
    }


      
}

extension CommentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "commentCell", for: indexPath)
        guard let commentCell = cell as? ChatListCell else { return UICollectionViewCell() }
        
        commentCell.authorLabel.text = dataSource[indexPath.row].author;
        commentCell.messageLabel.text = dataSource[indexPath.row].message;
        
        return commentCell
    }
}

extension CommentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 125)
    }
}
