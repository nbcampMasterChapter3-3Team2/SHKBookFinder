//
//  SearchTabViewController+DataSource.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import UIKit

extension SearchTabViewController: UICollectionViewDataSource {
    
    // MARK: - Methods

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return searchViewModel.state.collectionViewSection.value.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let section = searchViewModel.state.collectionViewSection.value[section]

        if section == .recentlyViewedBook {
            return searchViewModel.state.recentBooksSubject.value.count
        } else {
            return searchViewModel.state.bookResultSubject.value.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = searchViewModel.state.collectionViewSection.value[indexPath.section]

        if section == .recentlyViewedBook {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecentlyViewdBookCell.identifier,
                for: indexPath
            ) as! RecentlyViewdBookCell
            return cell
        }

        if section == .searchResult {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchResultCell.identifier,
                for: indexPath
            ) as! SearchResultCell

            let bookResult = searchViewModel.state.bookResultSubject.value
            let book = bookResult[indexPath.item]

            cell.configureComponent(with: book)
            return cell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.identifier,
                for: indexPath
            ) as! HeaderView

            let sectionType = searchViewModel.state.collectionViewSection.value[indexPath.section]
            header.configureTitle(sectionType.title)
            return header
        }
        return UICollectionReusableView()
    }
}


