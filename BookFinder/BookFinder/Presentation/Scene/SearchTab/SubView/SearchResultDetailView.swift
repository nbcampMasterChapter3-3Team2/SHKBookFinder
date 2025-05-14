//
//  SearchResultDetailView.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

import UIKit
import SnapKit
import Then

final class SearchResultDetailView: UIView {

    // MARK: - UI Components

    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.isScrollEnabled = true
    }

    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 10
    }

    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 23)
        $0.textColor = .black
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.lineBreakMode = .byTruncatingTail
    }

    private let authorLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 19)
        $0.textColor = .gray
        $0.numberOfLines = 0
        $0.textAlignment = .center
    }

    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 8
    }

    private let priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18)
        $0.textColor = .black
    }

    private let contentsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .darkGray
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.lineBreakMode = .byTruncatingMiddle
    }

    private let buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 15
        $0.distribution = .fillProportionally
    }

    private let cancelButton = UIButton().then {
        $0.setTitle("X", for: .normal)
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 10
    }

    private let addButton = UIButton().then {
        $0.setTitle("담기", for: .normal)
        $0.backgroundColor = .systemGreen
        $0.layer.cornerRadius = 10
    }

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
        [
            scrollView,
            buttonStackView
        ]
            .forEach { addSubview($0) }

        [
            contentStackView
        ]
            .forEach { scrollView.addSubview($0) }

        [
            titleLabel,
            authorLabel,
            imageView,
            priceLabel,
            contentsLabel,
        ]
            .forEach { contentStackView.addArrangedSubview($0) }

        [
            cancelButton,
            addButton
        ]
            .forEach { buttonStackView.addArrangedSubview($0) }
    }

    // MARK: - Layout Helper

    private func configureLayout() {
        scrollView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.bottom.equalTo(buttonStackView.snp.top)
        }

        scrollView.contentLayoutGuide.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        buttonStackView.snp.makeConstraints {
            $0.height.equalTo(55)
            $0.directionalHorizontalEdges.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(35)
        }

        contentStackView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
        }

        titleLabel.snp.makeConstraints {
            $0.width.equalToSuperview().inset(15)
        }

        authorLabel.snp.makeConstraints {
            $0.width.equalToSuperview().inset(20)
            $0.height.equalTo(30)
        }

        imageView.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(300)
        }

        contentsLabel.snp.makeConstraints {
            $0.width.equalToSuperview().inset(20)
        }

        cancelButton.snp.makeConstraints {
            $0.width.equalTo(addButton.snp.width).multipliedBy(0.5)
        }
    }

    // MARK: - Methods

    func configureComponent(with book: BookEntity) {
        titleLabel.text = book.title
        authorLabel.text = book.authors.joined(separator: " ")

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

        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let price = formatter.string(from: NSNumber(value: book.price)) else { return }
        priceLabel.text = "₩" + price

        contentsLabel.text = book.contents
    }
}
