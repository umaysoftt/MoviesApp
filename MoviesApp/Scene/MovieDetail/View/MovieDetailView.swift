//
//  MovieDetailView.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import UIKit
import Kingfisher
import FirebaseAnalytics

protocol MoviewDetailViewDelegate: AnyObject {
    func websiteButtonTapped(id: String)
}

final class MovieDetailView: UIView {

    // MARK: - UI Components
    weak var delegate: MoviewDetailViewDelegate?
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    lazy var movieImageView = UIImageView()
    lazy var imdbButton = UIButton()
    lazy var rateImageView = UIImageView()
    lazy var movieDate = UILabel()
    lazy var movieTitleLabel = UILabel()
    lazy var movieDescLabel = UILabel()
    lazy var movieRate = UILabel()
    lazy var headerLabel = UILabel()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MoviesCollectionViewCell.self, forCellWithReuseIdentifier: MoviesCollectionViewCell.Identifier.path.rawValue)
        return collectionView
    }()
    var imdb = ""

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI(){
        addViews()
        movieDate.font = UIFont(name: "SFProText-Semibold", size: 13)
        movieDate.textColor = .black
        movieTitleLabel.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        movieTitleLabel.textColor = .black
        movieTitleLabel.numberOfLines = 0
        movieDescLabel.font = UIFont(name: "SFProDisplay-Bold", size: 20)
        movieDescLabel.textColor = .black
        movieDescLabel.numberOfLines = 0
        movieRate.font = UIFont(name: "SFProDisplay-Bold", size: 13)
        movieRate.textColor = .black
        movieRate.numberOfLines = 0
        imdbButton.setImage(UIImage(named: "imdb"), for: .normal)
        imdbButton.addTarget(self, action: #selector(websiteButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        headerLabel.font = UIFont(name: "SFProText-Semibold", size: 45)
        headerLabel.textColor = .black
        headerLabel.text = "Similar Movies"


        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.scrollView)
            make.left.right.equalTo(self)
            make.width.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
        }

        movieImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.right.equalTo(0)
            make.height.equalTo(256)
        }

        imdbButton.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(16)
            make.left.equalTo(16)
            make.height.equalTo(24)
            make.height.equalTo(49)
        }

        rateImageView.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(20)
            make.left.equalTo(imdbButton.snp.right).offset(8)
            make.height.equalTo(16)
            make.width.equalTo(16)
        }

        movieDate.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(19)
            make.left.equalTo(movieRate.snp.right).offset(16)
        }

        movieTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(56)
            make.left.equalToSuperview().offset(16)
        }

        movieDescLabel.snp.makeConstraints { make in
            make.top.equalTo(movieTitleLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        movieRate.snp.makeConstraints { make in
            make.top.equalTo(movieImageView.snp.bottom).offset(19)
            make.left.equalToSuperview().offset(93)
            make.height.equalTo(19)
            make.width.equalTo(60)
        }

        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(movieDescLabel.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(16)
            make.height.equalToSuperview().multipliedBy(0.25)
        }
    }

    func addViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(movieImageView)
        contentView.addSubview(imdbButton)
        contentView.addSubview(rateImageView)
        contentView.addSubview(movieDate)
        contentView.addSubview(movieTitleLabel)
        contentView.addSubview(movieDescLabel)
        contentView.addSubview(movieRate)
        contentView.addSubview(collectionView)
        contentView.addSubview(headerLabel)
        contentView.backgroundColor = .white
        scrollView.backgroundColor = .white
    }

    @objc func websiteButtonTapped(_ sender: UIButton) {
        delegate?.websiteButtonTapped(id: self.imdb)
    }

    func populateUI(movie: MovieDetailModel) {
        let path = movie.posterPath ?? ""
        let baseURL = NetworkConstans.MovieServiceEndPoint.getImage()
        let urlString = baseURL + path
        guard let imageUrl = URL(string: urlString) else {
            return
        }
        rateImageView.image = UIImage(named: "rate")
        movieImageView.kf.setImage(with:imageUrl)

        movieRate.text = "\(String(format: "%.1f", movie.voteAverage ?? 0.0))/10"
        movieDate.text = DateFormatter.dateFormat(movie.releaseDate, format: "dd.MM.yyyy")
        movieTitleLabel.text = "\(String(describing: movie.title ?? "")) (\(DateFormatter.dateFormat(movie.releaseDate, format: "yyyy")))"
        let descriptionText = movie.overview?
            .replacingOccurrences(of: "<p>", with: "")
            .replacingOccurrences(of: "</p>", with: "")
            .replacingOccurrences(of: "<br>", with: "")
            .replacingOccurrences(of: "<br />", with: "")
        self.movieDescLabel.text = descriptionText
        self.imdb = movie.imdbID ?? ""

        FirebaseAnalytics.Analytics.logEvent("detail_screen_viewed", parameters: [
          AnalyticsParameterScreenName: "movies_detail_view",
          "movie_name": movie.title!
        ])
    }
}

