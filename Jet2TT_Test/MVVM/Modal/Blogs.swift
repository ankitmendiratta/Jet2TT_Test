//
//  Blogs.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserv
//

import UIKit
import ObjectMapper

class BlogsResponse : Mappable{
    
    var data : [Blogs]?
    required init?(map: Map){
    }
    
    func mapping(map: Map){
         data <- map["data"]
    }
}

class Blogs : Mappable{
    var id : String?
    var createdAt : String?
    var content : String?
    var comments: Int?
     var likes: Int?
    var media : [Media]?
    var user : [User]?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map){
        
        id <- map["id"]
        createdAt <- map["createdAt"]
        content <- map["content"]
        comments <- map["comments"]
        likes <- map["likes"]
        media <- map["media"]
        user <- map["user"]
    }
}

class Media : Mappable{

    var id : String?
    var blogId: String?
    var createdAt : String?
    var image : String?
    var title : String?
    var url : String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map){
        
        id <- map["id"]
        blogId <- map["blogId"]
        createdAt <- map["createdAt"]
        image <- map["image"]
        title <- map["title"]
        url <- map["url"]
        
    }
}

class User : Mappable{
    
    var id : String?
    var blogId: String?
    var createdAt : String?
    var name : String?
    var avatar : String?
    var lastname : String?
    var city : String?
    var designation : String?
    var about : String?
    
    required init?(map: Map){
    }
    
    func mapping(map: Map){
        
        id <- map["id"]
        blogId <- map["blogId"]
        createdAt <- map["createdAt"]
        name <- map["name"]
        avatar <- map["avatar"]
        lastname <- map["lastname"]
        city <- map["city"]
        designation <- map["designation"]
        about <- map["about"]
        
    }
}
