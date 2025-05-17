//
//  MyBookViewController+Delegate.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import UIKit

extension MyBookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.state.myBooks.value.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: MyBookCell.identifier
        ) as! MyBookCell

        let book = viewModel.state.myBooks.value[indexPath.item]
        cell.configureComponent(with: book)

        return cell
    }
}
