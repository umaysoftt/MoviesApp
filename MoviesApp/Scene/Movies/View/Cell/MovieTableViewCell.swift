//
//  MovieTableViewCell.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import UIKit
import Kingfisher

final class MovieTableViewCell: UITableViewCell {

    lazy var movieImage = UIImageView()
    lazy var movieTitle = UILabel()
    lazy var movieDescription = UILabel()
    lazy var movieDate = UILabel()
    lazy var arrowImage = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        viewConfigure()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    enum Identifier: String {
        case path = "TableViewCell"
    }
}

extension MovieTableViewCell {

     func viewConfigure(){
        contentView.backgroundColor = .white
        contentView.addSubview(movieImage)
        contentView.addSubview(movieTitle)
        contentView.addSubview(movieDescription)
        contentView.addSubview(movieDate)
        contentView.addSubview(arrowImage)
    }

     func setupUI(){

         movieImage.layer.cornerRadius = 12
         movieImage.layer.masksToBounds = true
         movieImage.clipsToBounds = true

         movieTitle.font = UIFont(name: "SFProText-Bold", size: 15)
         movieTitle.textColor = .black
         movieTitle.numberOfLines = 0

         movieDescription.font = UIFont(name: "SFProText-Semibold", size: 13)
         movieDescription.numberOfLines = 2
         movieDescription.textColor = .gray

         movieDate.font = UIFont(name: "SFProText-Semibold", size: 12)
         movieDate.textColor = .gray

         arrowImage.image = UIImage(systemName: "chevron.right")
         arrowImage.tintColor = .gray

         movieImage.snp.makeConstraints { make in
             make.top.bottom.left.equalToSuperview().offset(16)
             make.height.equalToSuperview().multipliedBy(0.76)
             make.width.equalToSuperview().multipliedBy(0.27)
         }
         movieTitle.snp.makeConstraints { make in
             make.top.equalToSuperview().offset(24)
             make.left.equalTo(movieImage.snp.right).offset(8)
             make.height.equalToSuperview().multipliedBy(0.17)
             make.width.equalToSuperview().multipliedBy(0.54)
         }
         movieDescription.snp.makeConstraints { make in
             make.top.equalTo(movieTitle.snp.bottom).offset(8)
             make.left.equalTo(movieImage.snp.right).offset(8)
             make.height.equalToSuperview().multipliedBy(0.25)
             make.right.equalTo(-44)
         }

         movieDate.snp.makeConstraints { make in
             make.top.equalTo(movieDescription.snp.bottom).offset(8)
             make.height.equalToSuperview().multipliedBy(0.13)
             make.right.equalTo(-44)
         }
         arrowImage.snp.makeConstraints { make in
             make.centerY.equalToSuperview()
             make.right.equalTo(-19)
         }
    }
     func set(_ movies: Movie) {
         guard let posterPath = movies.posterPath else {
             return
         }
         guard let imageUrl = URL(string: "\(NetworkConstans.MovieServiceEndPoint.getImage())\(posterPath)") else {
             return
         }
        DispatchQueue.main.async {
            self.movieImage.kf.setImage(with: imageUrl)
            self.movieTitle.text = "\(String(describing: movies.title ?? "")) (\(DateFormatter.dateFormat(movies.releaseDate, format: "yyyy")))"
            self.movieDescription.text = movies.overview
            self.movieDate.text = DateFormatter.dateFormat(movies.releaseDate, format: "dd.MM.yyyy")
        }
    }

}

