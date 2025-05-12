//
//  TabBarController.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

import UIKit

final class TabBarController: UITabBarController {

    private let searchTabViewController: SearchTabViewController
    private let bookListViewController: BookListViewController

    init(
        searchTabViewController: SearchTabViewController,
        bookListViewController: BookListViewController
    ) {
        self.searchTabViewController = searchTabViewController
        self.bookListViewController = bookListViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarItem()
        configureTabBarAppearance()
    }

    private func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        appearance.stackedLayoutAppearance.selected.iconColor = .black
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.black
        ]

        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        tabBar.tintColor = .black
        tabBar.unselectedItemTintColor = .gray
    }

    private func configureTabBarItem() {
        searchTabViewController.tabBarItem = UITabBarItem(
            title: "검색",
            image: UIImage(systemName: "magnifyingglass")?
                .withRenderingMode(.alwaysTemplate),
            selectedImage: nil
        )

        bookListViewController.tabBarItem = UITabBarItem(
            title: "나의 책",
            image: UIImage(systemName: "books.vertical")?
                .withRenderingMode(.alwaysTemplate),
            selectedImage: UIImage(systemName: "books.vertical.fill")?
                .withRenderingMode(.alwaysTemplate)
        )

        viewControllers = [
            searchTabViewController,
            bookListViewController
        ]
    }
}
