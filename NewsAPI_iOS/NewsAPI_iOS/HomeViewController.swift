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
    
    var selectedCountry = "in"
    var selectedCategory = "entertainment"
    var selectedIndexcountry : Int = 0
    var selectedIndexcategory : Int = 0
    
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
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.delegate = self
        vc.selectedIndexcountry = selectedIndexcountry
        vc.selectedIndexcategory = selectedIndexcategory
        self.present(vc, animated: true, completion: nil)
        
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

//MARK: - Protocol Use

extension HomeViewController: filterDataPassing{
    func filterDataPass(selecedCountry: String, selectedCategory: String, selectedIndexcountry: Int, selectedIndexcategory: Int) {
        
        self.selectedCategory = selectedCategory
        self.selectedIndexcategory = selectedIndexcategory
        self.selectedIndexcountry = selectedIndexcountry
        self.selectedCountry = selecedCountry
        
        //api call
    }
    
    
    
}
