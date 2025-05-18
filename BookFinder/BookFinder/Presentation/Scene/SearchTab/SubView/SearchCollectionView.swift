//
//  CollectionView.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

import UIKit
import SnapKit

final class SearchCollectionView: UIView {

    // MARK: - Properties

    var sections: [Section] = [] {
        didSet {
            collectionView.setCollectionViewLayout(createCompositionalLayout(sections: sections), animated: false)
        }
    }

    // MARK: - UI Components

    lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCompositionalLayout(sections: sections)
        )
        collectionView.register(RecentlyViewdBookCell.self, forCellWithReuseIdentifier: RecentlyViewdBookCell.identifier)
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.identifier)
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HeaderView.identifier
        )
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()

    // MARK: - Initializer, Deinit, requiered

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Hierarchy Helper

    private func configureHierarchy() {
        addSubview(collectionView)
    }

    // MARK: - Layout Helper

    private func configureLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func createCompositionalLayout(sections: [Section]) -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, environment in
            let section = sections[sectionIndex]

            if section == .recentlyViewedBook {
                return self?.createRecentlyViewedBookLayout(environment)
            }

            if section == .searchResult {
                return self?.createSearchResultLayout()
            }
            return self?.createSearchResultLayout()
        }
    }

    private func createRecentlyViewedBookLayout(_ environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(70),
            heightDimension: .absolute(70)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 12
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = .init(top: 0, leading: 22, bottom: 20, trailing: 0)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )

        section.boundarySupplementaryItems = [header]

        return section
    }

    private func createSearchResultLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(70)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        group.interItemSpacing = .fixed(10)

        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 15
        section.orthogonalScrollingBehavior = .none
        section.contentInsets = .init(top: 0, leading: 22, bottom: 0, trailing: 22)

        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(60)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.zIndex = 0

        section.boundarySupplementaryItems = [header]

        return section
    }
}
