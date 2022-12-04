//
//  MoviesView.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import UIKit

final class MoviesView: UIView {

    // MARK: - UI Components
    lazy var tableView = UITableView()
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    lazy var activityIndicator = UIActivityIndicatorView()
    lazy var searchBar: UISearchBar = {
           let searchBar = UISearchBar()
           searchBar.placeholder = "Search Movies..."
           searchBar.layer.cornerRadius = 20
           searchBar.setImage(UIImage(systemName: "magnifyingglass"), for: .search, state: .normal)
           searchBar.searchBarStyle = UISearchBar.Style.default
           searchBar.sizeToFit()
           searchBar.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           return searchBar
       }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        addSubviews()
        setupUI()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addSubviews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tableView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(searchBar)
        backgroundColor = .white
    }

    func setupUI() {

        tableView.rowHeight = UIScreen.main.bounds.height * 0.24
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.Identifier.path.rawValue)
        tableView.showsVerticalScrollIndicator = false

        searchBar.placeholder = "Search for movie.."
        searchBar.autocapitalizationType = .none

        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(self)
            make.width.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
        }

        scrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
        }

        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.width.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.15)
        }

        activityIndicator.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(200)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(8)
            make.left.right.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
}
