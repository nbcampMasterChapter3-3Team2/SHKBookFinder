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
        return Section.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Section(rawValue: section) {
        case .recentlyViewedBook:
            return 0
        case .searchResult:
            return searchViewModel.state.bookResultSubject.value.count
        default:
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch Section(rawValue: indexPath.section) {
        case .recentlyViewedBook:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: RecentlyViewdBookCell.identifier,
                for: indexPath
            ) as! RecentlyViewdBookCell
            return cell

        case .searchResult:
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchResultCell.identifier,
                for: indexPath
            ) as! SearchResultCell

            let bookResult = searchViewModel.state.bookResultSubject.value
            let book = bookResult[indexPath.item]

            cell.configureComponent(with: book)
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: HeaderView.identifier,
                for: indexPath
            ) as! HeaderView

            let sectionType = Section.allCases[indexPath.section]
            header.configureTitle(sectionType.title)
            return header
        }
        return UICollectionReusableView()
    }
}


