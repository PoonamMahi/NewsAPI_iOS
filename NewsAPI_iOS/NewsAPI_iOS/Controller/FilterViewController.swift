//
//  FilterViewController.swift
//  NewsAPI_iOS
//
//  Created by Poonam Mahi on 2022-04-16.
//
import UIKit


protocol filterDataPassing: AnyObject {
    
    func filterDataPass(selecedCountry:String,selectedCategory:String,selectedIndexcountry:Int,selectedIndexcategory:Int)
}



// MARK:----
/** this class is giving you options to choose country and category of news for  **Top-Headlines** Api of news. **CountryArray** are options of country and **categoryArray** is options of category
 **/
class FilterViewController: UIViewController {

    @IBOutlet weak var chooseCountryView: UILabel!
    @IBOutlet weak var chooseCategoryView: UILabel!
    @IBOutlet weak var continueBtnOutlet: UIButton!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var countryCollectionView: UICollectionView!
    var CountryArray = ["in","us","ae","jp","nz","eg"]
    var CountryArrayValue = ["India","USA","UAE","Japan","Newzealand","England"] // for display
    var categoryArray = ["entertainment","health","technology"]
    var categoryArrayValue = ["Entertainment","Health","Technology"] // for display
    var selectedCountry = "in"
    var selectedCategory = "entertainment"
    var selectedIndexcountry : Int = 0
    var selectedIndexcategory : Int = 0
    
    var delegate : filterDataPassing?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        // MARK: gave **tag** to collections view to recognize which collection view's cell is selected
        countryCollectionView.tag = 1
        categoryCollectionView.tag = 2
        selectedCountry = CountryArray.first!//forcely selected first index of country
        selectedCategory = categoryArray.first!//forcely selected first index of category
        // Do any additional setup after loading the view.
    }
    /** Preparing UI
     **/
    func prepareUI()  {
        continueBtnOutlet.layer.cornerRadius = 10
        chooseCountryView.layer.borderColor =  #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        chooseCountryView.layer.borderWidth = 1
        chooseCategoryView.layer.borderColor =  #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
        chooseCategoryView.layer.borderWidth = 1
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor :  #colorLiteral(red: 0.8470588235, green: 0.1960784314, blue: 0.2352941176, alpha: 1) ]
    }
    @IBAction func continueBtnClicked(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.filterDataPass(selecedCountry: self.selectedCountry, selectedCategory: self.selectedCategory, selectedIndexcountry: self.selectedIndexcountry, selectedIndexcategory: self.selectedIndexcategory)
        }
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let controller = storyboard.instantiateViewController(withIdentifier: "MainNewsViewController") as! HomeViewController
//        controller.choosedCountry = selectedCountry
//        controller.choosedCategory = selectedCategory
//        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
// MARK: extension for collection view delegates
extension FilterViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1{
            return CountryArray.count
        }else if collectionView.tag == 2{
            return categoryArray.count
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countryCell", for: indexPath) as! countryCell
            cell.textlabel.text = CountryArrayValue[indexPath.row]
            
            if indexPath.row == selectedIndexcountry{
                cell.backgroundColor =  #colorLiteral(red: 0.8470588235, green: 0.1960784314, blue: 0.2352941176, alpha: 1)
                cell.layer.borderWidth = 1
                cell.layer.borderColor =  #colorLiteral(red: 1, green: 0.09583883506, blue: 0.08748338686, alpha: 1)
                cell.textlabel.textColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                cell.backgroundColor =  #colorLiteral(red: 0.9764705882, green: 0.968627451, blue: 0.9764705882, alpha: 1)
                cell.layer.borderWidth = 1
                cell.layer.borderColor =  #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
                cell.textlabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! categoryCell
            cell.textLabel.text = categoryArrayValue[indexPath.row]
            if indexPath.row == selectedIndexcategory{
                cell.backgroundColor =  #colorLiteral(red: 0.8470588235, green: 0.1960784314, blue: 0.2352941176, alpha: 1)
                cell.layer.borderWidth = 1
                cell.layer.borderColor =  #colorLiteral(red: 1, green: 0.09583883506, blue: 0.08748338686, alpha: 1)
                cell.textLabel.textColor =  #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            }else{
                cell.backgroundColor =  #colorLiteral(red: 0.9764705882, green: 0.968627451, blue: 0.9764705882, alpha: 1)
                cell.layer.borderWidth = 1
                cell.layer.borderColor =  #colorLiteral(red: 0.8666666667, green: 0.8666666667, blue: 0.8666666667, alpha: 1)
                cell.textLabel.textColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1{
            return CGSize(width: collectionView.frame.width/3.0 - 20, height: collectionView.frame.height/2.0 - 20)
        }else{
            return CGSize(width: collectionView.frame.width/3.0 - 20, height: 100)
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 1{
            selectedCountry = CountryArray[indexPath.row]
            selectedIndexcountry = indexPath.row
            collectionView.reloadData()
        }else{
            selectedCategory = categoryArray[indexPath.row]
            selectedIndexcategory = indexPath.row
            collectionView.reloadData()
        }
    }
}

