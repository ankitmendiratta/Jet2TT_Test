//
//  APIHandler.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//

import Foundation
import ObjectMapper

extension HomeEndpoint{
    func handle(data : Any) -> Any? {
        
        switch self {

        case .blogs(_):
            let object = Mapper<BlogsResponse>().map(JSONObject: data)
            return object?.data
    
        }
    }
}
