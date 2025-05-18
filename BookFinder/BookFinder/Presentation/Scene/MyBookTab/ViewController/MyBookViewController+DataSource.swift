//
//  MyBookViewController+Delegate.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import UIKit

extension MyBookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.state.myBooksSubject.value.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBookCell.identifier, for: indexPath) as! MyBookCell

        let book = viewModel.state.myBooksSubject.value[indexPath.item].book
        cell.configureComponent(with: book)

        return cell
    }
}
