//
//  SourceWebNewsViewController.swift
//  NewsAPI_iOS
//
//  Created by Poonam Mahi on 2022-04-21.
//



import UIKit
import WebKit


class SourceNewsWebViewController: UIViewController {
    var url = String()
    @IBOutlet weak var newsWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setGUIScreen(url: url)
        newsWebView.navigationDelegate = self
        navigationController?.navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.title = "News"
    }

}
// MARK: extension containing functions **setGUIScreen** and **setGUIScreen**
extension SourceNewsWebViewController{
    /** **setGUIScreen** used for GUIScreen
     -parameters :
        -url : selected news url by user
     **/
    func setGUIScreen(url: String) {
        self.addActivityLoader()
        self.startAnimatingLoader()
        if let webUrl: NSURL = NSURL(string: url){
            let webRequest: NSURLRequest = NSURLRequest(url: webUrl as URL)
            newsWebView.load(webRequest as URLRequest)
        }
    }
}
// MARK: extension for delegates of **WKNavigationDelegate**

extension SourceNewsWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.stopAnimatingLoader()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.stopAnimatingLoader()
        let alert = UIAlertController(title: "Sorry!", message: "There might be an technical or internet issue", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { alert -> Void in
            self.navigationController?.popToRootViewController(animated: true)
        })
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
