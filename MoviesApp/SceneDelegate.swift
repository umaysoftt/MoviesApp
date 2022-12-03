//
//  SceneDelegate.swift
//  MoviesApp
//
//  Created by İsmail Palalı on 3.12.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let service = MoviesManager ()
        let viewModel = MoviesViewModel(service: service)
        let mainViewController = MoviesViewController(viewModel)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

