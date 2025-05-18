//
//  SearchTabViewController+.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import UIKit
import RxSwift
import RxCocoa

extension SearchTabViewController: UICollectionViewDelegate {

    // MARK: - Methods

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let section = searchViewModel.state.collectionViewSection.value[indexPath.section]

        if section == .recentlyViewedBook {
        }

        if section == .searchResult {
            let books = searchViewModel.state.bookResultSubject.value
            let selectedBook = books[indexPath.item]

            searchViewModel.action.accept(.bookResultCellTapped(selectedBook))
        }
    }
}

extension SearchTabViewController: UISearchBarDelegate {

    // MARK: - Methods

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.keyboardAppearance = .default
        searchBar.keyboardType = .default
    }
}

extension SearchTabViewController: UIScrollViewDelegate {

    // MARK: - Methods

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if !searchBar.searchTextField.hasText {
            searchBar.setShowsCancelButton(false, animated: true)
        }
        view.endEditing(true)
    }
}
