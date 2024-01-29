//
//  TopHeadlinesCollectionViewCell.swift
//  NewsApp
//
//  Created by Gorkem Saka on 26.01.2024.
//

import UIKit
import SnapKit
import SDWebImage

class TopHeadlinesCollectionViewCell: UICollectionViewCell {
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
    
    override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
       }
       required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
   
    //MARK: - Functions
    private func configure(){
        drawDesign()
        constraints()
    }
}
extension TopHeadlinesCollectionViewCell {
    private func drawDesign(){
        backgroundColor = .white
        
        layer.cornerRadius = 20
        layer.masksToBounds = false
        layer.borderWidth = 2
        layer.borderColor = UIColor.gray.cgColor
        
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
            make.leading.equalToSuperview().offset(Theme.Size.leadingOffset.rawValue * 2)
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

extension TopHeadlinesCollectionViewCell {
    func getData(model: Article){
        newsFromLabel.text = model.source.name
        newsTitleLabel.text = model.title
        newsImageView.sd_setImage(with: URL(string: model.urlToImage ?? ""))
        newsSubTitleLabel.text = model.description
        publishedTimeLabel.text = model.publishedAt
   }
    override func prepareForReuse() {
        newsImageView.image = nil
    }
}

