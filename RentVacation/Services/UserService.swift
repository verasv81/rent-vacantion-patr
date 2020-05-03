//
//  UserService.swift
//  RentVacation
//
//  Created by Vera Svet on 5/2/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import Foundation
import RxSwift


class UserService {
    let request = RequestService()
    let basePath = "http://localhost:4000/user";
    
    func getUser(id: String?) -> Observable<User> {
        var userId = id
        if(userId == nil) {
            userId = "5e84fa631c9d440000e0a2c8"
        }
        let path = self.basePath + "/" + userId!;
        let url = URL(string: path)
        let urlRequest = URLRequest(url: url!);
        let subscription: Observable<User> = request.get(urlRequest).observeOn(MainScheduler.instance)
       
        return subscription
    }
    
    func login(name: (String), password: (String)) -> (Observable<User>){
        let url = self.basePath + "/login"
        let user = User(name: name, password: password)
        let subscription: Observable<User> = request.post(url, parameters: user).observeOn(MainScheduler.instance)
        return subscription
    }
    
    func signup(name: (String), password: (String)) -> (Observable<User>) {
        let user = User(name: name, password: password)
        let subscription: Observable<User> = request.post(self.basePath, parameters: user).observeOn(MainScheduler.instance);
        
        return subscription
    }
    
    
}
