//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import UIKit
import SnapKit

final class MoviesViewController: UIViewController, UISearchBarDelegate {

    // MARK: - UI Components
    lazy var tableView = UITableView()
    lazy var scrollView = UIScrollView()
    lazy var contentView = UIView()
    lazy var activityIndicator = UIActivityIndicatorView()
    lazy var searchBar = UISearchBar()

    // MARK: - Properties
    private let viewModel: MoviesViewModel
    private var currentPage = 0

    // MARK: - Initialization
    init(_ viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }

    @available(*, unavailable)
      public required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
      }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList()
        addSubviews()
        setupDelegates()
        setupUI()
        configureRefreshControl()
    }

    private func fetchList() {
        viewModel.output = self
        activityIndicator.startAnimating()
        viewModel.getUpcomingList()
    }
    @objc func handleRefreshControl() {
       fetchList()
        self.activityIndicator.startAnimating()
       DispatchQueue.main.async {
          self.scrollView.refreshControl?.endRefreshing()
           self.activityIndicator.stopAnimating()
       }
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.datasourceUpcoming.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:MovieTableViewCell.Identifier.path.rawValue, for: indexPath) as? MovieTableViewCell
        cell?.set(viewModel.datasourceUpcoming[indexPath.row])
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.16
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectItemAtTableview(indexPath)
    }
}


// MARK: - MoviesViewModelOutput Output
extension MoviesViewController: MoviesViewModelOutput {
    func showProductDetail(_ movie: MovieResult) {
        // TODO IMPLEMENT
    }

    func reloadList() {
        activityIndicator.stopAnimating()
        self.tableView.reloadData()
    }
}

extension MoviesViewController {
    func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(tableView)
        contentView.addSubview(activityIndicator)
        contentView.addSubview(searchBar)
        view.backgroundColor = .white
    }

    func setupDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
    }

    func setupUI() {

        tableView.rowHeight = UIScreen.main.bounds.height * 0.24
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.Identifier.path.rawValue)
        tableView.showsVerticalScrollIndicator = false

        searchBar.placeholder = "Search for movie.."
        searchBar.autocapitalizationType = .none

        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }

        contentView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.scrollView)
            make.left.right.equalTo(self.view)
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

    func configureRefreshControl () {
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(self, action:
                                                #selector(handleRefreshControl),
                                             for: .valueChanged)
    }
}
