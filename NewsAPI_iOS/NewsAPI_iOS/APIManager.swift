//
//  APIManager.swift
//  NewsAPI_iOS
//
//  Created by Poonam Mahi on 2022-04-21.
//

import Foundation
class APIManager{

/**
     - Api is for getting all news related to country and category
     - Parameters :
        - page : no of page result u need **Pagination**
        - country : name of country
        - category : choosed category (entertainment,business etc.)
     **/
    static func getNews(country : String, category : String , page : Int, success:@escaping (NewsDataModel)->(), failure:@escaping (Bool)->() ) {
        
        var url = URL(string: "https://newsapi.org/v2/top-headlines")!
        url.appendQueryItem(name: "country", value: country)
        url.appendQueryItem(name: "category", value: category)
        url.appendQueryItem(name: "apiKey", value: "ebbd885ace1349919ca0a3d9678c09da")
        url.appendQueryItem(name: "page", value: String(page))
        url.appendQueryItem(name: "pageSize", value: "4")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
                let data = try JSONDecoder().decode(NewsDataModel.self, from: data!)
                success(data)
            } catch {
                print("error")
                failure(true)
            }
        })

        task.resume()
        
        
        }
    
/**
     - Api is for getting all news related to what user searched and it will give 10 results only
     - Parameters :
        - page : no of page result u need (statically it is set to 1 only)
        - character : text or characters searched by User
     **/
    static func searchNews(query : String, page : Int, success: @escaping (NewsDataModel)->(), failure: @escaping (Bool)->() ) {
        
        
        var url = URL(string: "https://newsapi.org/v2/everything")!
        url.appendQueryItem(name: "q", value: query)
        url.appendQueryItem(name: "sortBy", value: "publishedAt")
        url.appendQueryItem(name: "apiKey", value: "ebbd885ace1349919ca0a3d9678c09da")
        url.appendQueryItem(name: "page", value: String(page))
        url.appendQueryItem(name: "pageSize", value: "10")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            print(response!)
            do {
    let data = try JSONDecoder().decode(NewsDataModel.self, from: data!)
                success(data)
            } catch {
                print("error")
                failure(true)
            }
        })

        task.resume()
    }
}
