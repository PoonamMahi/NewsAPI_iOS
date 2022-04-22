//
//  Extensions.swift
//  NewsAPI_iOS
//
//  Created by Poonam Mahi on 2022-04-21.
//

import Foundation
import UIKit

//MARK: - extension for UIViewcontroller
extension UIViewController{

    //func for adding loader in any View controller
    func addActivityLoader(){
        let loader = UIActivityIndicatorView()
        loader.tag = 1
        loader.color = .white
        loader.style = .large
        loader.hidesWhenStopped = true
        loader.backgroundColor =  #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.35)
        loader.frame.size.height = 70.0
        loader.frame.size.width = 70.0
        loader.center = CGPoint(x: self.view.frame.size.width  / 2, y: (self.view.frame.size.height / 2)-70)
        loader.layer.cornerRadius = 8
        self.view.addSubview(loader)
    }

    //start activity indicator to animate
    func startAnimatingLoader(){
        if let activityIndicator = self.view.subviews.filter(
            { $0.tag == 1}).first as? UIActivityIndicatorView {
                activityIndicator.startAnimating()
            }
    }

    //stopping activity indicator to animate
    func stopAnimatingLoader() {
        DispatchQueue.main.async {
            if let activityIndicator = self.view.subviews.filter(
                { $0.tag == 1}).first as? UIActivityIndicatorView {
                    activityIndicator.stopAnimating()
                    activityIndicator.removeFromSuperview()
                }
        }
       
    }
}
    extension URL {

        mutating func appendQueryItem(name: String, value: String?) {

            guard var urlComponents = URLComponents(string: absoluteString) else { return }

            // Create array of existing query items
            var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

            // Create query item
            let queryItem = URLQueryItem(name: name, value: value)

            // Append the new query item in the existing query items array
            queryItems.append(queryItem)

            // Append updated query items array in the url component object
            urlComponents.queryItems = queryItems

            // Returns the url from new url components
            self = urlComponents.url!
        }
    }



