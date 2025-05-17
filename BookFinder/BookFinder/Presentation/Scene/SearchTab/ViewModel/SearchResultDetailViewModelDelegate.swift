//
//  SearchResultDetailViewModelDelegate.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

protocol SearchResultDetailViewModelDelegate: AnyObject {
    func didRequestDismiss()
    func didTapAddBook()
}
