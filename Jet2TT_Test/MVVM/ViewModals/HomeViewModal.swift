//
//  HomeViewModal.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit

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
                arrBlogs.append(contentsOf: arrayTemp)
                delegate?.reloadTableView()
            }
        case .failure(let error):
            self.showErrorMessage(error: error)
        }
    }

    
      func showErrorMessage(error: String?) {
           //Show error message here
      }
}
