//
//  HomeViewModal.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit
import CoreData
protocol HomeApiListener: class {
    func reloadTableView()
    func loadNextPage()
}

class HomeViewModal {
    
    weak var delegate: HomeApiListener?
    var arrBlogs = [Blogs]()
    private let itemsPerPage = 10
    private var currentPage = 0
    private var isFinished = false
    
    private var isAPIRunning = false
    
    var IsFavSetAPIProcessing : Bool = false
    
    func getArticleList(){
        if isAPIRunning || isFinished {
            return
        }
        currentPage = currentPage + 1
        isAPIRunning = true
        HomeEndpoint.blogs(page: "\(/currentPage)", limit: "\(/itemsPerPage)").request {[weak self] (response) in
            self?.responseHandler(response: response)
        }
    }
    
    
    func responseHandler(response : Response){
        isAPIRunning = false
        switch response {
        case .success(let list):
            guard let arrayTemp = list as? [Blogs] else {return}
            if arrayTemp.count == 0{
                isFinished = true
            }else{
                self.saveDataToCore(arrBlogs: arrayTemp)
                arrBlogs.append(contentsOf: arrayTemp)
                delegate?.reloadTableView()
            }
        case .failure(let error):
            self.showErrorMessage(error: error)
            arrBlogs = self.fetchAllDataFromCore()
            delegate?.reloadTableView()
        }
    }
    
    
    func showErrorMessage(error: String?) {
        //Show error message here
    }
    
    
    
    
    
    func saveDataToCore(arrBlogs : [Blogs]){
        
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "BlogModel", in: context)
        for each in arrBlogs{
            let fetchRq = NSFetchRequest<NSFetchRequestResult>.init(entityName: "BlogModel")
            fetchRq.fetchLimit = self.itemsPerPage
            fetchRq.fetchOffset = self.currentPage
            fetchRq.predicate = NSPredicate(format: "id == \(each.id ?? "0")")
            do {
                let blogs = try context.fetch(fetchRq)
                if blogs.count == 0 {
                    let blog = NSManagedObject(entity: entity!, insertInto: context)
                    blog.setValue(each.id, forKey: "id")
                    blog.setValue(each.comments, forKey: "comments")
                    blog.setValue(each.content, forKey: "content")
                    blog.setValue(each.createdAt, forKey: "createdAt")
                    blog.setValue(each.likes, forKey: "likes")
                    
                    
                    if each.media!.count > 0 {
                        if let media = each.media?[0]
                        {
                            blog.setValue(media.id, forKey: "mediaid")
                            let entity2 = NSEntityDescription.entity(forEntityName: "MediaModel", in: context)
                            let mediaModel = NSManagedObject(entity: entity2!, insertInto: context)
                            mediaModel.setValue(media.blogId, forKey: "blogId")
                            mediaModel.setValue(media.createdAt, forKey: "createdAt")
                            mediaModel.setValue(media.id, forKey: "id")
                            mediaModel.setValue(media.image, forKey: "image")
                            mediaModel.setValue(media.title, forKey: "title")
                            mediaModel.setValue(media.url, forKey: "url")
                        }
                    }
                    
                    
                    if each.user!.count > 0 {
                        if let user = each.user?[0]
                        {
                            blog.setValue(user.id, forKey: "userid")
                            let entity2 = NSEntityDescription.entity(forEntityName: "UserModel", in: context)
                            let userModel = NSManagedObject(entity: entity2!, insertInto: context)
                            userModel.setValue(user.avatar, forKey: "avatar")
                            userModel.setValue(user.designation, forKey: "designation")
                            userModel.setValue(user.id, forKey: "id")
                            userModel.setValue(user.lastname, forKey: "lastname")
                            userModel.setValue(user.name, forKey: "name")
                        }
                    }
                    
                    
                }else{
                    // no need to add
                }
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
        }
        do {
            try context.save()
        }catch let error as NSError{
            print("Eror: \(error.userInfo)")
        }
    }
    
    
    func fetchAllDataFromCore() ->  [Blogs]{
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchRq = NSFetchRequest<BlogModel>.init(entityName: "BlogModel")
        var result = [Blogs]()
        do {
            
            let blogs = try context.fetch(fetchRq)
            if blogs.count > 0 {
                let  arrResult = self.convertToJSONArray(moArray: blogs)
                for each in blogs{
                    let model = Blogs.init(JSON: arrResult[0])
                    if let mediaId = each.mediaid{
                        let media = try self.fetchMedia(mediaID: mediaId)
                        model?.media = [media]
                    }else{
                         model?.media = []
                    }
                    let user = try self.fetchUser(userId: each.userid!)
                    model?.user = [user]
                    result.append(model!)
                }
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return result
        
    }
    
    
    func fetchMedia(mediaID : String) throws -> Media {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchRq2 = NSFetchRequest<MediaModel>.init(entityName: "MediaModel")
        fetchRq2.predicate = NSPredicate(format: "id contains[c] %@", mediaID)
        let result2 = try context.fetch(fetchRq2)
        let  arrResult = self.convertToJSONArray(moArray: result2)
        let model = Media.init(JSON: arrResult[0])
        return model!
    }
    
    
    func fetchUser(userId : String) throws -> User {
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let fetchRq2 = NSFetchRequest<UserModel>.init(entityName: "UserModel")
        fetchRq2.predicate = NSPredicate(format: "id contains[c] %@", userId)
        let result2 = try context.fetch(fetchRq2)
        let  arrResult = self.convertToJSONArray(moArray: result2)
        let model = User.init(JSON: arrResult[0])
        return model!
    }
    
    func convertToJSONArray(moArray: [NSManagedObject]) -> [[String: Any]] {
        var jsonArray: [[String: Any]] = []
        for item in moArray {
            var dict: [String: Any] = [:]
            for attribute in item.entity.attributesByName {
                //check if value is present, then add key to dictionary so as to avoid the nil value crash
                if let value = item.value(forKey: attribute.key) {
                    dict[attribute.key] = value
                }
            }
            jsonArray.append(dict)
        }
        return jsonArray
    }
    
}
