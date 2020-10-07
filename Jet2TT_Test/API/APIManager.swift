//
//  APIManager.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//


import Foundation

import Alamofire

typealias Completion = (Response) -> ()

class APIManager : NSObject{
    
    static let shared = APIManager()
    private lazy var httpClient : HTTPClient = HTTPClient()
    
    func request(with api : Router , isLoaderNeeded : Bool?, completion : @escaping Completion ){
        
        if !isConnectedToNetwork() {
            print("No Internet connection")
            completion(Response.failure("No Internet connection"))
        }
        
        if isLoaderNeeded == true{
            Utility.shared.loader()
        }
        
        httpClient.postRequest(withApi: api, success: {(data) in
            Utility.shared.removeLoader()
            
            guard let response = data else {
                completion(Response.failure(.none))
                return
            }
            
            var json = [String : Any]()
            
            if let respon = response as? [String : Any]{
                json = respon
            }else {
                
                guard let array = response as? [Any] else{ completion(Response.failure(.none))
                    return }
                let respon = ["data" : array]
                json = respon
            }
            
            print(json)
            let object = api.handle(data: json)
            completion(Response.success(object))
            
            
        }, failure: { message in
            
            Utility.shared.removeLoader()
            completion(Response.failure(message))
        })
    }
    
    func isConnectedToNetwork() -> Bool {
        
        guard let reachability = Alamofire.NetworkReachabilityManager()?.isReachable else { return false }
        return reachability ? true: false
    }
}
