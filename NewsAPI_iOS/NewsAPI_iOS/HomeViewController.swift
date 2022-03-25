//
//  HomeViewController.swift
//  NewsAPI_iOS
//
//  Created by Poonam Mahi on 2022-03-25.
//


import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewUI()
    }
    
    //TableView setup
    func setupTableViewUI(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
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
