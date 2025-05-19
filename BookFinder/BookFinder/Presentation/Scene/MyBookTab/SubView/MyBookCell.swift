//
//  MyBookCell.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import UIKit
import SnapKit
import Then

class MyBookCell: UITableViewCell {

    // MARK: - Properties

    static let identifier = "MyBookCell"

    // MARK: - UI Components

    private var titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .black
        $0.numberOfLines = 3
        $0.setContentCompressionResistancePriority(
            .defaultLow,
            for: .horizontal
        )
    }

    private var authorLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.numberOfLines = 2
        $0.lineBreakMode = .byTruncatingTail
        $0.textAlignment = .right
        $0.textColor = .gray
    }

    private var priceLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 12)
        $0.textColor = .black
    }

    // MARK: - Initializer, Deinit, requiered

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierarchy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Hierarchy Helper

    private func configureHierarchy() {
        [
            titleLabel,
            authorLabel,
            priceLabel
        ]
            .forEach { contentView.addSubview($0) }
    }

    // MARK: - Layout Helper

    private func configureLayout() {
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.black.cgColor

        titleLabel.snp.makeConstraints {
            $0.leading.top.equalToSuperview().offset(10)
            $0.width.equalTo(contentView.snp.width).multipliedBy(0.6)
        }

        authorLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(10)
            $0.top.equalToSuperview().offset(10)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(authorLabel.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().inset(10)
        }
    }

    // MARK: - Methods

    func configureComponent(with book: BookEntity) {
        self.titleLabel.text = book.title

        self.authorLabel.text = book.authors.joined(separator: " ")

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let price = formatter.string(from: NSNumber(value: book.price)) else { return }
        self.priceLabel.text = "₩" + price
    }
}

extension MyBookCell {
    func setCardStyle() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        layer.cornerRadius = 12
        layer.masksToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        clipsToBounds = false
    }
}
