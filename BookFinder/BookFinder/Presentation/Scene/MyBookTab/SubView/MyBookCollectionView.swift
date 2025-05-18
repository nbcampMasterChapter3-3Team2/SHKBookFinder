//
//  CollectionView.swift
//  BookFinder
//
//  Created by kingj on 5/18/25.
//

import UIKit
import SnapKit

final class MyBookCollectionView: UIView {

    // MARK: - UI Components

    lazy var collectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCompositionalLayout()
        )
        collectionView.register(MyBookCell.self, forCellWithReuseIdentifier: MyBookCell.identifier)
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

    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
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

        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}
