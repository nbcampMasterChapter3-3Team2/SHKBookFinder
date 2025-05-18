//
//  MyBookViewController+Delegate.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import UIKit

extension MyBookViewController: UITableViewDataSource {

    // MARK: - Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.state.myBooksSubject.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MyBookCell.identifier
        ) as! MyBookCell

        let book = viewModel.state.myBooksSubject.value[indexPath.section].book
        cell.configureComponent(with: book)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }

    // 셀 간 간격
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 15
    }

    // 셀 간 간격을 위한 viwe
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let spacer = UIView()
        spacer.backgroundColor = .clear
        return spacer
    }
}
