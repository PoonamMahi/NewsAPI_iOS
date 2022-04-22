//
//  NewsDataModel.swift
//  NewsAPI_iOS
//
//  Created by Poonam Mahi on 2022-04-21.
//

import Foundation
struct NewsDataModel : Decodable{
    let status : String
    let totalResults : Int
    let articles : [Articles]?
}

struct Articles : Decodable{
    let source : Source?
    let author,title,description,url,urlToImage,publishedAt,content : String?
}

struct Source : Decodable {
    let id,name : String?
}

