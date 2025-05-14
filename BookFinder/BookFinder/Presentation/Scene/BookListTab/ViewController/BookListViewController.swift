//
//  BookListViewController.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

import UIKit

final class BookListViewController: UIViewController {

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        configureBarButtonItem()
    }

    // MARK: - Methods

    private func configureNavigationItem() {
        self.navigationItem.title = "담은 책"
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
    }

    private func configureBarButtonItem() {
        let deleteAll = UIButton(type: .system)
        deleteAll.setTitle("전체 삭제", for: .normal)
        deleteAll.setTitleColor(.gray, for: .normal)
        deleteAll.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        deleteAll.addTarget(self, action: #selector(onTappedDeleteAll), for: .touchUpInside)

        let leftBarButton = UIBarButtonItem(customView: deleteAll)
        self.navigationItem.leftBarButtonItem = leftBarButton

        let addBook = UIButton(type: .system)
        addBook.setTitle("추가", for: .normal)
        addBook.setTitleColor(.systemOrange, for: .normal)
        addBook.titleLabel?.font = .boldSystemFont(ofSize: 15)
        addBook.addTarget(self, action: #selector(onTappedAddBook), for: .touchUpInside)

        let rightBarButton = UIBarButtonItem(customView: addBook)
        self.navigationItem.rightBarButtonItem = rightBarButton

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .white

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    // MARK: - @objc Methods

    @objc
    private func onTappedDeleteAll() {
        print("delete all")
    }

    @objc
    private func onTappedAddBook() {
        print("add book")
    }

}
