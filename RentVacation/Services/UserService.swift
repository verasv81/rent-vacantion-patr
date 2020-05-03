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
    
    func getUser(id: String?) -> String {
        let path = self.basePath + "/" + id!;
        let url = URL(string: path)
        let urlRequest = URLRequest(url: url!);
        let subscription2: Observable<User> = request.get(urlRequest).observeOn(MainScheduler.instance)
        var name = ""
        var completed = false
    
        let _ = subscription2.subscribe{ event in
            switch event {
            case .next(let value):
                name = value.name
            case .error(let error):
                print(error)
            case .completed:
                completed = true
            }
        }
        
        if (completed == false) {
            return ""
        }
        return name
    }
    
    func login(name: (String), password: (String)) -> (String, Bool){
        let url = self.basePath + "/login"
        let user = User(name: name, password: password)
        let subscription1: Observable<User> = request.post(url, parameters: user).observeOn(MainScheduler.instance);
        var name = ""
        var isLogged = false
        
        let _ = subscription1.subscribe {event in
            switch event {
            case .next(let value):
                name = self.getUser(id: value._id)
                print(value)
            case .error(let error):
                print(error)
            case .completed:
                isLogged = true
            }
        }
        
        return(name, isLogged)
    }
    
    func signup(name: (String), password: (String)) -> (String, Bool) {
        let user = User(name: name, password: password)
        let subscription1: Observable<User> = request.post(self.basePath, parameters: user).observeOn(MainScheduler.instance);
        
        var name = ""
        var isLogged = false
        
        let _ = subscription1.subscribe {event in
            switch event {
            case .next(let value):
                name = self.getUser(id: value._id)
            case .error(let error):
                print(error)
            case .completed:
                isLogged = true
            }
        }
        
        return (name, isLogged)
    }
    
    
}
