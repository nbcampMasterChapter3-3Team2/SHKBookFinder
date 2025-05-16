//
//  SearchResultDetailViewController.swift
//  
//
//  Created by kingj on 5/12/25.
//

import UIKit
import SnapKit
import RxSwift

class SearchResultDetailViewController: UIViewController {

    // MARK: - Properties

    private let viewModel: SearchResultDetailViewModel
    private let disposeBag = DisposeBag()

    // MARK: - UI Components

    private let detailView = SearchResultDetailView()

    // MARK: - Initializer, requiered

    init(
        viewModel: SearchResultDetailViewModel
    ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStyle()
        configureHierarchy()
        configureLayout()
        bind()
    }

    // MARK: - Bind

    private func bind() {
        viewModel.state.bindedBookSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] book in
                guard let self, let book else { return }
                detailView.configureComponent(with: book)
            }, onError: { error in
                print("[Error] Selected Book Bind \(error)")
            }).disposed(by: disposeBag)
    }

    // MARK: - Style Helper

    private func configureStyle() {
        view.backgroundColor = .white
    }

    // MARK: - Hierarchy Helper

    private func configureHierarchy() {
        [
            detailView
        ]
            .forEach { view.addSubview($0) }
    }

    // MARK: - Layout Helper

    private func configureLayout() {
        detailView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
