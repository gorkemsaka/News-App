//
//  TopHeadlinesTableViewCell.swift
//  NewsApp
//
//  Created by Gorkem Saka on 23.01.2024.
//

import UIKit
import SnapKit
import SDWebImage

class TopHeadlinesTableViewCell: UITableViewCell {
    //MARK: - UI Elements
    private let newsFromLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.font = Theme.Font.subtitleFont
        label.textColor = Theme.Color.subtitleColor
        return label
    }()
    private let newsTitleLabel: UILabel = {
        var label = UILabel()
        label.font = .systemFont(ofSize: 30, weight: .bold)
        label.font = Theme.Font.titleFont
        label.textColor = Theme.Color.titleColor
        label.numberOfLines = 3
        return label
    }()
    private let newsImageView: UIImageView = {
        var image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        return image
    }()
    private let newsSubTitleLabel: UILabel = {
        var label = UILabel()
        label.font = Theme.Font.subtitleFont
        label.textColor = Theme.Color.subtitleColor
        label.numberOfLines = 3
        return label
    }()
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.Color.appBackgroundColor
        return view
    }()
    private let publishedTimeLabel: UILabel = {
        var label = UILabel()
        label.font = Theme.Font.subtitleFont
        label.textColor = Theme.Color.subtitleColor
        return label
    }()
    //MARK: - Properties
    //MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Functions
    private func configure(){
        drawDesign()
        constraints()
    }
}
//MARK: - Draw Design & Constraints
extension TopHeadlinesTableViewCell {
    private func drawDesign(){
        addSubview(newsFromLabel)
        addSubview(newsTitleLabel)
        addSubview(newsImageView)
        addSubview(newsSubTitleLabel)
        addSubview(dividerView)
        addSubview(publishedTimeLabel)
    }
    private func constraints(){
        newsFromLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Theme.Size.topOffset.rawValue)
            make.leading.equalToSuperview().offset(Theme.Size.leadingOffset.rawValue)
        }
        newsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsFromLabel.snp.bottom)
            make.leading.equalToSuperview().offset(Theme.Size.leadingOffset.rawValue)
            make.trailing.equalToSuperview().offset(Theme.Size.trailingOffset.rawValue)
            
        }
        newsImageView.snp.makeConstraints { make in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(Theme.Size.topOffset.rawValue)
            make.leading.equalToSuperview().offset(Theme.Size.leadingOffset.rawValue)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        newsSubTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(newsTitleLabel.snp.bottom).offset(Theme.Size.topOffset.rawValue)
            make.leading.equalTo(newsImageView.snp.trailing).offset(Theme.Size.leadingOffset.rawValue)
            make.trailing.equalToSuperview().offset(Theme.Size.trailingOffset.rawValue)
        }
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(newsImageView.snp.bottom).offset(10)
            make.height.equalTo(1)
            make.leading.equalToSuperview().offset(Theme.Size.leadingOffset.rawValue)
            make.trailing.equalToSuperview().offset(Theme.Size.trailingOffset.rawValue)
        }
        publishedTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.leading.equalToSuperview().offset(Theme.Size.leadingOffset.rawValue)
        }
    }
}
//MARK: - Get UI Elements data
extension TopHeadlinesTableViewCell {
     func getData(model: Article){
         newsFromLabel.text = model.source.name
         newsTitleLabel.text = model.title
         newsImageView.sd_setImage(with: URL(string: model.urlToImage ?? ""))
         newsSubTitleLabel.text = model.description
         publishedTimeLabel.text = model.publishedAt
    }
}


