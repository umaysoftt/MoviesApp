//
//  MovieDetailViewController.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import UIKit
import Kingfisher
import SafariServices
import SnapKit

final class MovieDetailViewController: UIViewController {

    // MARK: - Properties
    private lazy var viewSource: MovieDetailView = {
        let view = MovieDetailView()
        view.delegate = self
        return view
    }()

    var viewModel: MoviesDetailViewModel!

    private let movieID: Int
    private var imdb = ""

    // MARK: - Initialization
    init(movieID: Int) {
        self.movieID = movieID
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDelegates()
        fetchMovie()
        view.backgroundColor = .white
        backButton()
        networkCheck()
    }

    private func setupDelegates() {
        viewSource.collectionView.delegate = self
        viewSource.collectionView.dataSource = self
        self.view = viewSource


    }

    private func fetchMovie() {
        viewModel.getMovieDetail(movieID)
        viewModel.getSimilarMovies(movieID)
    }


    private func backButton() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }

    @objc func goBack() {
        self.navigationController?.popViewController(animated: true)
    }

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
    }
}
extension MovieDetailViewController: MoviesDetailViewModelOutput {

    func reloadList() {
        viewSource.collectionView.reloadData()
    }

    func showErrorMessage(title: String, message: String) {
        showAlert(title: "Error", message: message)
    }

    func displayMovieDetail(_ movie: MovieDetailModel) {
        navigationItem.title = "\(String(describing: movie.title ?? "")) (\(DateFormatter.dateFormat(movie.releaseDate, format: "yyyy")))"
        viewSource.populateUI(movie: movie)
    }
}

extension MovieDetailViewController: MoviewDetailViewDelegate {
    func websiteButtonTapped(id: String) {
        guard let url = URL(string: "\(NetworkConstans.MovieServiceEndPoint.getIMDB())\(id)") else {
            return
        }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}

extension MovieDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return viewModel.similarMovies.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.Identifier.path.rawValue, for: indexPath) as? MoviesCollectionViewCell
            cell?.set(viewModel.similarMovies[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
}
