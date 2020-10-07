//
//  HomeViewController.swift
//  Jet2TT_Test
//
//  Created by Ankit on 06/10/2020.
//  Copyright © 2020 Ankit. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    lazy var viewModel = HomeViewModal()
    @IBOutlet weak var tableView: UITableView!
    
    var tableDatasource : TableViewDataSource?{
        didSet{
            tableView?.dataSource = tableDatasource
            tableView?.delegate = tableDatasource
            tableView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.getArticleList()
    }
    
}

extension HomeViewController : HomeApiListener{
    func reloadTableView(){
        self.configureTableView()
    }
    func loadNextPage(){
        self.tableDatasource?.tableView?.reloadData()
    }
    
    func configureTableView(){
        tableDatasource = TableViewDataSource(items: viewModel.arrBlogs, height: UITableView.automaticDimension, tableView: tableView, cellIdentifier: .Home)
           tableDatasource?.configureCellBlock = {(cell,item,indexpath) in
               if let modal = item as? Blogs, let eachCell = cell as? HomeCell {
                        eachCell.modal = modal
               }
           }
            tableDatasource?.scrollViewListener = {(scrollView) in
                //No need
            }
            tableDatasource?.preFetchData = {
                self.viewModel.getArticleList()
            }
       }
    
    
}

