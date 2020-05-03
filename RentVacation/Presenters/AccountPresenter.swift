//
//  AccountPresenter.swift
//  RentVacation
//
//  Created by Vera Svet on 5/2/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import Foundation

class AccountPresenter {
    private let userService: UserService
    weak private var accountViewDelegate : AccountViewDelegate?
    
    init(userService: UserService){
        self.userService = userService
    }
    
    func setViewDelegate(accountViewDelegate: AccountViewDelegate?){
        self.accountViewDelegate = accountViewDelegate
    }
    
    func setUser(id: (String)){
        let user = self.userService.getUser(id: id)
        accountViewDelegate?.displayUser(name: user)
    }
    
    func login(name: (String), password: (String)) {
        self.accountViewDelegate?.login(name: name, password: password)
    }
    
    func signup(name: (String), password: (String)) {
        self.accountViewDelegate?.login(name: name, password: password)
    }
}
