//
//  MoviesViewController.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import UIKit
import SnapKit

final class MoviesViewController: UIViewController {

    // MARK: - Properties
    private lazy var viewSource: MoviesView = {
        let view = MoviesView()
        //view.delegate = self
        return view
    }()
    // MARK: - Properties
    private let viewModel: MoviesViewModel

    // MARK: - Initialization
    init(_ viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = viewSource
        setupDelegates()
        fetchList()
        configureRefreshControl()

    }

    private func fetchList() {

        viewSource.activityIndicator.startAnimating()
        viewModel.getUpcomingList()
        networkCheck()
    }
    @objc func handleRefreshControl() {
       fetchList()
        viewSource.activityIndicator.startAnimating()
       DispatchQueue.main.async {
           self.viewSource.scrollView.refreshControl?.endRefreshing()
           self.viewSource.activityIndicator.stopAnimating()
       }
    }

    func setupDelegates() {
        viewModel.output = self
        viewSource.tableView.delegate = self
        viewSource.tableView.dataSource = self
        viewSource.searchBar.delegate = self
        navigationItem.title = "Movies"
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
    func showErrorMessage(title: String, message: String) {
        showAlert(title: title, message: message)
    }

    func showMovieDetail(_ movie: Movie) {
        let controller = MovieDetailViewController(movieID: movie.id ?? 0)
        let viewModel = MoviesDetailViewModel(output: controller, service: Services())
        controller.viewModel = viewModel
        navigationController?.pushViewController(
            controller,
            animated: true
        )
    }

    func reloadList() {
        viewSource.activityIndicator.stopAnimating()
        viewSource.tableView.reloadData()
    }
}

extension MoviesViewController {
    private func networkCheck() {
        if Reachability.isConnectedToNetwork() {
            print("Network is connected")
        } else {
            print("Network is not connected")
            showAlert(title: "Error", message:" Please connect to internet")
        }
    }

    private func showAlert(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(ok)
        controller.addAction(cancel)
        present(controller, animated: true, completion: nil)
        viewSource.activityIndicator.stopAnimating()
    }
    func configureRefreshControl () {
        viewSource.scrollView.refreshControl = UIRefreshControl()
        viewSource.scrollView.refreshControl?.addTarget(self, action:
                                                #selector(handleRefreshControl),
                                             for: .valueChanged)
    }
}

extension MoviesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchMovie(movie: searchText)
    }
}
