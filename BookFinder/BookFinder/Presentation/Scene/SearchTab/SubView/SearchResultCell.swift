//
//  SearchResultCell.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

import UIKit
import SnapKit

final class SearchResultCell: UICollectionViewCell {

    // MARK: - Properties

    static let identifier = "SearchResultCell"

    // MARK: - Initializer, Deinit, requiered

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    // MARK: - Methods

    private func configureView() {
        self.contentView.backgroundColor = .systemRed
    }
}
