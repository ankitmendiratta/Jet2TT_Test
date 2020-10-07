
//  APIConstants.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//


import Foundation

internal struct APIConstants {
    
    struct Basepath {
        static let baseServerURL = "https://5e99a9b1bc561b0016af3540.mockapi.io/jet2/api/v1/"
    }
    static let blogs = "blogs"
}

enum Keys : String{
    case page = "page"
    case limit = "limit"
}


enum Validate : String {
    
    case failure = "False"
    case success = "True"
    
    func map(response message : String?) -> String? {
        
        return message
        
    }
}

enum Response {
    case success(Any?)
    case failure(String?)
}

typealias OptionalDictionary = [String : Any]?

struct Parameters {
    static let blogs : [Keys] = [.page, .limit]
}

