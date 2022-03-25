//
//  HomeViewController.swift
//  NewsAPI_iOS
//
//  Created by Poonam Mahi on 2022-03-25.
//


import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewUI()
        searchBarSetup()
    }
    
    //TableView setup
    func setupTableViewUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }
    
    // setting up searchBar
    func searchBarSetup(){
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationController?.view.backgroundColor = .white
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by article, news"
        searchController.searchBar.tintColor = .black
        searchController.searchBar.textContentType = UITextContentType(rawValue: "")
        searchController.searchBar.searchTextField.font = UIFont(name: "Helvetica Neue", size: 14)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        print("filter button pressed")
        
    }
    
    
    

}

//MARK:- tableView delegate functions
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCardTableViewCell", for: indexPath) as! newsCardTableViewCell
        
        return cell
    }
    
}

//MARK:- search bar delegate function
extension HomeViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
       
    }
}
