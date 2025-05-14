//
//  Coordinator.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

import UIKit

final class Coordinator {

    // MARK: - Properties

    let diContainer: DIContainer
    private(set) var rootViewController: UIViewController?

    // MARK: - Initializer, Deinit, requiered

    init(
        diContainer: DIContainer
    ) {
        self.diContainer = diContainer
    }

    // MARK: - Methods

    func start() {
        let tabBarController = TabBarController(
            searchTabViewController: diContainer.makeSearchTabViewController(),
            bookListViewController: diContainer.makeBookListViewController()
        )
        self.rootViewController = tabBarController
    }
}
