//
//  DiContainer+ViewController.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

extension DIContainer {
    func makeSearchTabViewController() -> SearchTabViewController {
        SearchTabViewController(
            searchViewModel: makeSearchTabViewModel(),
            detailViewModel: makeSearchResultDetailViewModel()
        )
    }

    func makeBookListViewController() -> BookListViewController {
        BookListViewController()
    }
}
