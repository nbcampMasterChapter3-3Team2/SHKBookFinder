//
//  SearchResultDetailViewController+delegate.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

extension SearchResultDetailViewController: SearchResultDetailViewModelDelegate {
    func didRequestDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func didTapAddBook(_ result: Bool) {

        // TODO: result에 따른 Alert

        didRequestDismiss()
    }
}
