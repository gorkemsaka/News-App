//
//  NewsModel.swift
//  NewsApp
//
//  Created by Gorkem Saka on 1/23/24.
//

import Foundation

struct ArticlesModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    struct Source: Codable {
        let id: String?
        let name: String
    }
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

