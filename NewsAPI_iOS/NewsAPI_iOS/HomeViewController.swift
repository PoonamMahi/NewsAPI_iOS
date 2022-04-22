//
//  HomeViewController.swift
//  NewsAPI_iOS
//
//  Created by Poonam Mahi on 2022-03-25.
//


import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    var selectedCountry = "in"
    var selectedCategory = "entertainment"
    var selectedIndexcountry : Int = 0
    var selectedIndexcategory : Int = 0
    var currentPage : Int = 1
    var newsArticlesDataModel = [Articles]()
    var newsArticlesDataModelCopy = [Articles]()
    var totalPages : Int = 0
    var isApiCall : Bool = true
    var isFromSearch : Bool = false
    var q : String = ""
    var isSearchApiCall = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewUI()
        searchBarSetup()
        getNews(country: selectedCountry, category: selectedCategory, page: currentPage)
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
        return newsArticlesDataModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCardTableViewCell", for: indexPath) as! newsCardTableViewCell
        cell.newsArticleTitle.text = newsArticlesDataModel[index].title
        cell.newsArticleDesc.text = newsArticlesDataModel[index].description
        cell.newsArticleContent.text = newsArticlesDataModel[index].content
        if let string = newsArticlesDataModel[index].publishedAt{
            if let range = string.range(of: "T") {
                let subStr = string[string.startIndex..<range.lowerBound]
                var datee = [String]()
                datee.append(String(subStr))
                cell.newsArticlePublishedDate.text = datee[0]
            }
        }
        cell.newsArticleAuthor.text = newsArticlesDataModel[index].author
        if let imageUrl = newsArticlesDataModel[index].urlToImage{
            if let url = URL(string: imageUrl){
                cell.newsArticleImage.sd_setImage(with: url)
            }
        }
        
       
                   //api call
        if isFromSearch{
            if indexPath.item == self.newsArticlesDataModel.count - 1 && isSearchApiCall == true{
                        self.isSearchApiCall = false
                        self.currentPage += 1
            searchNews(query: q, page: currentPage)
            }
        } else {
            if indexPath.item == self.newsArticlesDataModel.count - 1 && isApiCall == true{
                        self.isApiCall = false
                        self.currentPage += 1
            getNews(country: selectedCountry, category: selectedCategory, page: currentPage)
        }
    }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
       let controller = storyboard.instantiateViewController(withIdentifier: "SourceNewsWebViewController") as! SourceNewsWebViewController
       if let newsUrl = newsArticlesDataModel[index].url{
           controller.url = newsUrl
       }
       self.navigationController?.pushViewController(controller, animated: true)
   }
}

//MARK:- search bar delegate function
extension HomeViewController:UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        q = text
        if q == "" {
            self.newsArticlesDataModel = self.newsArticlesDataModelCopy
            self.tableView.reloadData()
            return
        }
        currentPage = 1
        self.newsArticlesDataModel.removeAll()
        searchNews(query: text, page: currentPage)
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
        self.currentPage = 1
        self.newsArticlesDataModel.removeAll()
        self.newsArticlesDataModelCopy.removeAll()
        getNews(country: selecedCountry, category: selectedCategory, page: currentPage)
    }
}


//MARK: - API call
extension HomeViewController{
    
    /**
         - Api is for getting all news related to country and category
         - Parameters :
            - page : no of page result u need **Pagination**
            - country : name of country
            - category : choosed category (entertainment,business etc.)
         **/
    
    func getNews(country: String, category: String, page: Int){
        self.addActivityLoader()
        self.startAnimatingLoader()
        APIManager.getNews(country: country, category: category, page: page) { data in
           
            if self.newsArticlesDataModel.count > 0 && data.articles?.count == 0 {
                self.isApiCall = false
            }else {
                self.isApiCall = true
                if let data = data.articles{
                    self.newsArticlesDataModel += data
                    self.newsArticlesDataModelCopy += data
                }
                self.totalPages = data.totalResults
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.stopAnimatingLoader()
                }
            }
           
            
        } failure: { failure in
            self.stopAnimatingLoader()
            print("failed")
        }
    }
    
    /**
         - Api is for getting all news related to what user searched and it will give 10 results only
         - Parameters :
            - page : no of page result u need (statically it is set to 1 only)
            - character : text or characters searched by User
         **/
    func searchNews(query : String, page: Int){
        self.addActivityLoader()
        self.startAnimatingLoader()
        APIManager.searchNews(query: query, page: page) { data in
            
            if self.newsArticlesDataModel.count > 0 && data.articles?.count == 0 {
                self.isSearchApiCall = false
            }else {
                self.isSearchApiCall = true
                if let data = data.articles{
                    self.newsArticlesDataModel += data
                }
                self.totalPages = data.totalResults
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.stopAnimatingLoader()
                }
            }
            
        } failure: { failure in
            self.stopAnimatingLoader()
            print("failed")
        }
    }
}
