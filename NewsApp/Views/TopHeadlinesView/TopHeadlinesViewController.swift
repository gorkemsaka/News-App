//
//  TopHeadlinesViewController.swift
//  NewsApp
//
//  Created by Gorkem Saka on 1/22/24.
//

import UIKit
import SnapKit

protocol ViewModelPresenter {
    func fetchNews(values: [Article?])
}
class TopHeadlinesViewController: UIViewController {
    //MARK: - UI Elements
    private let welcomeHeader: UILabel = {
        var label = UILabel()
        label.font = Theme.Font.headerFont
        label.text = Theme.Texts.welcomeMessage.rawValue
        label.textAlignment = .left
        label.textColor = Theme.Color.titleColor
        label.numberOfLines = 3
        return label
    }()
    private let welcomeSubHeader: UILabel = {
        var label = UILabel()
        label.font = Theme.Font.subHeaderFont
        label.text = Theme.Texts.titleMessage.rawValue
        label.textColor = Theme.Color.subtitleColor
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    private let topHeadLinesTableView: UITableView = {
        var tableView = UITableView()
        tableView.rowHeight = 240
        tableView.separatorStyle = .none
        tableView.separatorColor = .clear
        return tableView
    }()
    //MARK: - Properties
    private lazy var newsList: [Article?] = []
    var viewModel: ITopHeadlinesViewModel = TopHeadlinesViewModel()
    
    //MARK: - Life Cycyle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        viewModel.setDelegate(output: self)
        viewModel.fetchNews()
    }
    //MARK: - Configure
    private func configure(){
        DispatchQueue.main.async {
            self.view.backgroundColor = Theme.Color.appBackgroundColor
        }
        topHeadLinesTableView.register(TopHeadlinesTableViewCell.self, forCellReuseIdentifier: Theme.Identifier.topHeadlinesCell.rawValue)
        drawDesign()
        constraints()
    }
}
//MARK: - Draw Design
extension TopHeadlinesViewController {
    private func drawDesign(){
        view.addSubview(welcomeHeader)
        view.addSubview(welcomeSubHeader)
        view.addSubview(topHeadLinesTableView)
        view.backgroundColor = .white
        
        topHeadLinesTableView.delegate = self
        topHeadLinesTableView.dataSource = self
    }
}
//MARK: - Constraints
extension TopHeadlinesViewController {
    private func constraints(){
        welcomeHeaderConstraints()
        welcomeSubHeaderConstraints()
        tableViewConstraints()
    }
    private func welcomeHeaderConstraints(){
        welcomeHeader.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(Theme.Size.leadingOffset.rawValue)
            make.trailing.equalToSuperview().offset(Theme.Size.trailingOffset.rawValue)
        }
    }
    private func welcomeSubHeaderConstraints(){
        welcomeSubHeader.snp.makeConstraints { make in
            make.top.equalTo(welcomeHeader.snp.bottom)
            make.leading.equalToSuperview().offset(Theme.Size.leadingOffset.rawValue)
            make.trailing.equalToSuperview().offset(Theme.Size.trailingOffset.rawValue)
        }
    }
    private func tableViewConstraints() {
        topHeadLinesTableView.snp.makeConstraints { make in
            make.top.equalTo(welcomeSubHeader.snp.bottom).offset(Theme.Size.topOffset.rawValue * 3)
            make.leading.equalToSuperview().offset(Theme.Size.leadingOffset.rawValue)
            make.trailing.equalToSuperview().offset(Theme.Size.trailingOffset.rawValue)
            make.bottom.equalToSuperview()
        }
    }
}
//MARK: - TableView Setup
extension TopHeadlinesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentNews = newsList[indexPath.row]
        guard let cell: TopHeadlinesTableViewCell = topHeadLinesTableView.dequeueReusableCell(withIdentifier: Theme.Identifier.topHeadlinesCell.rawValue) as? TopHeadlinesTableViewCell else {
            return UITableViewCell()
        }
        cell.getData(model: currentNews!)
        return cell
    }
}
//MARK: - Get Data
extension TopHeadlinesViewController: ViewModelPresenter {
    func fetchNews(values: [Article?]) {
        newsList = values
        DispatchQueue.main.async {
            self.topHeadLinesTableView.reloadData()
        }
    }
}
