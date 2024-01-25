//
//  NewsService.swift
//  NewsApp
//
//  Created by Gorkem Saka on 1/23/24.
//

import Foundation
protocol INewsService {
    func fetchTopHeadlines(completion: @escaping([Article]?)-> Void)
}

class NewsService: INewsService {
    func fetchTopHeadlines(completion: @escaping ([Article]?) -> Void) {
        let url = URL(string: API_URL.fetchTopHeadlines())
        URLSession.shared.dataTask(with: url!) {data, response, error in
            if let expectedError = error {
                print(expectedError.localizedDescription)
                completion(nil)
            }
            if let safeData = data {
                let topHeadlinessNews = try? JSONDecoder().decode(ArticlesModel.self, from: safeData)
                if let news = topHeadlinessNews {
                    completion(news.articles)
                }
            }
        }.resume()
    }
}
