//
//  MoviesCollectionViewCell.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import UIKit

final class MoviesCollectionViewCell: UICollectionViewCell {

    enum Identifier: String {
        case path = "CollectionViewCell"
    }

    lazy var movieImageCollectionView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        viewConfigure()
        setupUICollectionView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func viewConfigure(){
       contentView.addSubview(movieImageCollectionView)
   }

    func setupUICollectionView(){
        movieImageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        movieImageCollectionView.contentMode = .scaleToFill
        movieImageCollectionView.clipsToBounds = true
        movieImageCollectionView.layer.cornerRadius = 10
        movieImageCollectionView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
   }

   public func set(_ movies: Movie) {
       guard let posterPath = movies.posterPath else {
           return
       }
       guard let imageUrl = URL(string: "\(NetworkConstans.MovieServiceEndPoint.getImage())\(posterPath)") else {
           return
       }
       DispatchQueue.main.async {
           self.movieImageCollectionView.kf.setImage(with: imageUrl)
       }
   }

}



