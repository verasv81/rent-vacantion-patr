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
        var name = ""
        let _ = self.userService.getUser(id: id).subscribe { event in
            switch event {
            case .next(let value):
                name = value.name
            case .error(let error):
                print(error)
            case .completed:
                self.accountViewDelegate?.displayUser(name: name)
            }
        }
    }
    
    func login(name: (String), password: (String)) {
        var userName = name
        var userPassword = password
        if(userName=="" && userPassword=="") {
            userPassword = "1234"
            userName = "Felix"
        }
        let _ = self.userService.login(name: userName, password: userPassword).subscribe {event in
            switch event {
            case .next(let value):
                self.setUser(id: value._id!)
            case .error(let error):
                print(error)
            case .completed:
                print("is logged")
            }
        }
    }
    
    func signup(name: (String), password: (String)) {
        let _ = self.userService.signup(name: name, password: password).subscribe {event in
             switch event {
             case .next(let value):
                self.setUser(id: value._id!)
             case .error(let error):
                 print(error)
             case .completed:
                 print("is logged")
             }
         }
    }
}
