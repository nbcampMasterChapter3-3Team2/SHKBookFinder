//
//  MyBookViewController+DataSource.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import UIKit

extension MyBookViewController: UITableViewDelegate {

    // MARK: - Methods

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.backgroundColor = .clear
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { [weak self] _, _, completion in
            guard let self else { return }
            let isbn = self.viewModel.state.myBooksSubject.value[indexPath.row].book.isbn
            self.viewModel.action.accept(.swipeToDeleteBook(isbn: isbn))
            completion(true)
        }
        deleteAction.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
