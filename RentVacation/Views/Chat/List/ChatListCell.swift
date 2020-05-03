//
//  ChatListCell.swift
//  RentVacation
//
//  Created by Vera Svet on 2/20/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import UIKit

final class ChatListCell: UICollectionViewCell {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var avatarImage: UIImageView!
    
    override func awakeFromNib() {
          super.awakeFromNib()
          // Initialization code
      }
}
