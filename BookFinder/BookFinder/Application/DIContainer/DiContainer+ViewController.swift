//
//  DiContainer+ViewController.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

extension DIContainer {
    func makeSearchTabViewController() -> SearchTabViewController {
        SearchTabViewController()
    }

    func makeBookListViewController() -> BookListViewController {
        BookListViewController()
    }
}
