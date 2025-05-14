//
//  HeaderView.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

import UIKit
import SnapKit

final class HeaderView: UICollectionReusableView {

    // MARK: - Properties

    static let identifier = "HeaderView"

    // MARK: - UI Components

    private let title: UILabel = {
        let title = UILabel()
        title.font = .boldSystemFont(ofSize: 20)
        return title
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
        addSubview(title)
    }

    // MARK: - Layout Helper

    private func configureLayout() {
        title.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Methods

    func configureTitle(_ text: String) {
        title.text = text
    }
}
