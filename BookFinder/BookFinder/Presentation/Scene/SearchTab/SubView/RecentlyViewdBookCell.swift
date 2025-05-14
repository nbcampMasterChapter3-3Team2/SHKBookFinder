//
//  RecentlyViewdBookCell.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

import UIKit
import SnapKit

final class RecentlyViewdBookCell: UICollectionViewCell {

    // MARK: - Properties
    
    static let identifier = "RecentlyViewdBookCell"

    private let imageView = UIImageView().then {
        $0.layer.cornerRadius = 70 / 2
    }

    // MARK: - Initializer, Deinit, requiered
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Style Helper

    private func configureStyle() {
        imageView.backgroundColor = .white
    }

    // MARK: - Hierarchy Helper

    private func configureHierarchy() {
        addSubview(imageView)
    }

    // MARK: - Layout Helper

    private func configureLayout() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
