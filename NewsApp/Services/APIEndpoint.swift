//
//  APIEndpoint.swift
//  NewsApp
//
//  Created by Gorkem Saka on 1/23/24.
//

import Foundation
enum API_URL: String {
    case BASE_URL = "https://newsapi.org/v2"
    case topHeadlinesAPI_KEY = "/top-headlines?country=us&apiKey=2d96e25446184eb586f1a0d98281f3c3"
    
    static func fetchTopHeadlines() -> String {
        return "\(BASE_URL.rawValue)\(topHeadlinesAPI_KEY.rawValue)"
    }
}
