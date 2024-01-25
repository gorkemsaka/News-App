//
//  TopHeadlinesViewModel.swift
//  NewsApp
//
//  Created by Gorkem Saka on 1/23/24.
//

import Foundation
protocol ITopHeadlinesViewModel {
    var service: INewsService { get }
    var newsList: [Article]? { get set }
    var viewModelPresenter: ViewModelPresenter? { get }
    func fetchNews()
    func setDelegate(output: ViewModelPresenter)
}

class TopHeadlinesViewModel: ITopHeadlinesViewModel {
    //MARK: - Properties
    var service: INewsService
    var newsList: [Article]? = []
    var viewModelPresenter: ViewModelPresenter?
    
    init() {
        self.service = NewsService()
    }
    //MARK: - fetchNews
    func fetchNews() {
        service.fetchTopHeadlines { [weak self] response in
            self?.newsList = response ?? []
            self?.viewModelPresenter?.fetchNews(values: self?.newsList ?? [])
        }
    }
    func setDelegate(output: ViewModelPresenter) {
        viewModelPresenter = output
    }
}
