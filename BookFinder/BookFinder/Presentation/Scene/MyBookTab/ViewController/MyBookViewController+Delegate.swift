//
//  MyBookViewController+DataSource.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import UIKit

extension MyBookViewController: UICollectionViewDelegate {

//    func tableView(
//        _ tableView: UITableView,
//        commit editingStyle: UITableViewCell.EditingStyle,
//        forRowAt indexPath: IndexPath
//    ) {
//        if editingStyle == .delete {
//            let books = viewModel.state.myBooksSubject.value
//            let isbn = books[indexPath.section].book.isbn
//            viewModel.action.accept(.swipeToDeleteBook(isbn: isbn))
//
//            tableView.deleteSections(IndexSet(integer: indexPath.section), with: .automatic)
//        }
//    }
//
//    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
//        "삭제하기"
//    }
}
