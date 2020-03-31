//
//  ChatListModel.swift
//  RentVacation
//
//  Created by Vera Svet on 2/20/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

final class ChatListModel {
    let author: String
    let message: String
    let avatarUrl: String
    
    init(author: String, message: String, avatarUrl: String) {
        self.author = author;
        self.message = message;
        self.avatarUrl = avatarUrl;
    }
}
