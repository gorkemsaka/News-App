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
    private let topHeadLinesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
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
            self.topHeadLinesCollectionView.backgroundColor = Theme.Color.appBackgroundColor
        }
        topHeadLinesCollectionView.register(TopHeadlinesCollectionViewCell.self, forCellWithReuseIdentifier: Theme.Identifier.topHeadlinesCell.rawValue)
        drawDesign()
        constraints()
    }
}
//MARK: - Draw Design
extension TopHeadlinesViewController {
    private func drawDesign(){
        view.addSubview(welcomeHeader)
        view.addSubview(welcomeSubHeader)
        view.addSubview(topHeadLinesCollectionView)
        topHeadLinesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        topHeadLinesCollectionView.delegate = self
        topHeadLinesCollectionView.dataSource = self
    }
}
//MARK: - Constraints
extension TopHeadlinesViewController {
    private func constraints(){
        welcomeHeaderConstraints()
        welcomeSubHeaderConstraints()
        collectionViewConstraints()
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
    private func collectionViewConstraints() {
        topHeadLinesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(welcomeSubHeader.snp.bottom).offset(Theme.Size.topOffset.rawValue * 3)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
//MARK: - CollectionView Setup
extension TopHeadlinesViewController: UICollectionViewDelegate,UICollectionViewDataSource  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentNews = newsList[indexPath.row]
        guard let cell : TopHeadlinesCollectionViewCell = topHeadLinesCollectionView.dequeueReusableCell(withReuseIdentifier: Theme.Identifier.topHeadlinesCell.rawValue, for: indexPath) as? TopHeadlinesCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.getData(model: currentNews!)
        return cell
    }
}
extension TopHeadlinesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 20
        let height: CGFloat = 250

           return CGSize(width: width, height: height)
    }
}

//MARK: - Get Data
extension TopHeadlinesViewController: ViewModelPresenter {
    func fetchNews(values: [Article?]) {
        newsList = values
        DispatchQueue.main.async {
            self.topHeadLinesCollectionView.reloadData()
        }
    }
}
