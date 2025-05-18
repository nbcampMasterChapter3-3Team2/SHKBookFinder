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
        $0.contentMode = .scaleAspectFill
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

    // MARK: - Hierarchy Helper

    private func configureHierarchy() {
        addSubview(imageView)
    }

    // MARK: - Layout Helper

    private func configureLayout() {
        imageView.snp.makeConstraints {
            $0.size.equalTo(70)
            $0.edges.equalToSuperview()
        }
    }

    // MARK: - Methods

    func configureComponent(with book: BookEntity) {
        guard let url = URL(string: book.thumbnail) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async { [weak self] in
                        guard let self else { return }
                        self.imageView.image = image
                    }
                }
            }
        }
    }
}
