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

        switch Section(rawValue: indexPath.section) {
        case .recentlyViewedBook: return
        case .searchResult:

            if case .success(let books) = currentState.fetchSearchBook {

                let selected = books[indexPath.item]
                let viewModel = SearchResultDetailViewModel()
                DispatchQueue.main.async {
                    viewModel.action?(.bindSelectedBook(selected))
                }

                let vc = SearchResultDetailViewController(viewModel: viewModel)

                present(vc, animated: true)
            }
//            else {
//                let searchResultDetailVC = SearchResultDetailViewController(book: books)
//                present(searchResultDetailVC, animated: true)
//            }
        default: return
        }
    }
}

extension SearchTabViewController: UISearchBarDelegate {

    // MARK: - Methods

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] quary in
                guard let self else { return }
                viewModel.action?(.fetchSearchBookResult(quary))
            }).disposed(by: disposeBag)
    }

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
