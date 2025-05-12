//
//  ViewController.swift
//  BookFinder
//
//  Created by kingj on 5/11/25.
//

import UIKit
import Then
import SnapKit

final class SearchTabViewController: UIViewController {

    private lazy var searchBar = UISearchBar().then {
        $0.delegate = self
        $0.placeholder = "입력"
        $0.searchBarStyle = .minimal
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        [
            searchBar
        ]
            .forEach { view.addSubview($0) }

        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
}

extension SearchTabViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("input: \(searchText)")
    }
}
