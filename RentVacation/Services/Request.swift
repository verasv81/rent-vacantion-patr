//
//  Request.swift
//  RentVacation
//
//  Created by Vera Svet on 3/27/20.
//  Copyright © 2020 Vera Svet. All rights reserved.
//

import Alamofire
import RxSwift

class RequestService {
    func get<T: Codable>(_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<T>.create { observer in
            //Trigger the HttpRequest using AlamoFire (AF)
            let request = AF.request(urlConvertible).responseDecodable { (response: DataResponse<T, AFError>) in
                //Check the result from Alamofire's response and check if it's a success or a failure
                switch response.result {
                case .success(let value):
                    //Everything is fine, return the value in onNext
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    //Something went wrong, switch on the status code and return the error
                    observer.onError(error)
                }
            }
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
            }
        }
    }

    func post<T: Codable ,Y: Codable>(_ urlConvertible: URLConvertible, parameters: T) -> Observable<Y> {
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        return Observable<Y>.create { observer in
            //Trigger the HttpRequest using AlamoFire (AF)
            let request = AF.request(urlConvertible, method: .post, parameters: parameters, encoder: JSONParameterEncoder.default).responseDecodable { (response: DataResponse<Y, AFError>) in
                switch response.result {
                case .success(let value):
                    //Everything is fine, return the value in onNext
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    //Something went wrong, switch on the status code and return the error
                    observer.onError(error)
                }            }
            
            //Finally, we return a disposable to stop the request
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
