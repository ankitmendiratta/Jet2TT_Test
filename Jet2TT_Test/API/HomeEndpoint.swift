//
//  HomeEndpoint.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit
import Alamofire

protocol Router {
    var route : String { get }
    var parameters : OptionalDictionary { get }
    var method : Alamofire.HTTPMethod { get }
    func handle(data : Any) -> Any?
}

enum HomeEndpoint {
    case blogs(page: String?, limit : String?)
}


extension HomeEndpoint : Router{
    
    func request(isLoaderNeeded: Bool? = true , completion: @escaping Completion) {
        APIManager.shared.request(with: self, isLoaderNeeded: isLoaderNeeded, completion: completion)
    }
    
    var route : String  {
        
        switch self {
       
        case .blogs(let page, let limit): return "\(APIConstants.blogs)?page=\(/page)&limit=\(/limit)"
       
        }
    }
    
    var parameters: OptionalDictionary{
        return format()
    }
    
    
    func format() -> OptionalDictionary {
        switch self {
        case .blogs(_):
            return [:]
        }
    }
    
    var method : Alamofire.HTTPMethod {
        switch self {
        case .blogs: return .get
        default: return .post
            
        }
    }    
}
