//
//  BookListViewController.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

final class MyBookViewController: UIViewController {

    // MARK: - Properties

    let viewModel: MyBookViewModel
    private let disposeBag = DisposeBag()

    // MARK: - UI Components

    private let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.register(MyBookCell.self, forCellReuseIdentifier: MyBookCell.identifier)
        $0.separatorStyle = .none
        $0.backgroundColor = .white
        $0.showsVerticalScrollIndicator = false
    }

    private let deleteAllButton = UIButton(type: .system).then {
        $0.setTitle("전체 삭제", for: .normal)
        $0.setTitleColor(.gray, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
    }

    private let addBookButton = UIButton(type: .system).then {
        $0.setTitle("추가", for: .normal)
        $0.setTitleColor(.systemOrange, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
    }

    // MARK: - Initializer, Deinit, requiered

    init(
        viewModel: MyBookViewModel
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
        configureNavigationItem()
        configureBarButtonItem()
        configureHierarchy()
        configureLayout()
        configureDelegate()
        bind()
        viewModel.action.accept(.fetchAllMyBooks)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.action.accept(.fetchAllMyBooks)
    }

    // MARK: - Hierarchy Helper

    private func configureHierarchy() {
        [
            tableView
        ]
            .forEach { view.addSubview($0) }
    }

    // MARK: - Bind

    private func bind() {
        viewModel.state.myBooksSubject
            .bind(to: tableView.rx.items(
                cellIdentifier: MyBookCell.identifier,
                cellType: MyBookCell.self)
            ) { _, item, cell in
                cell.configureComponent(with: item.book)
                cell.selectionStyle = .none
                cell.setCardStyle()
            }.disposed(by: disposeBag)

        tableView.rx.itemDeleted
            .bind { [weak self] indexPath in
                guard let self else { return }
                let isbn = self.viewModel.state.myBooksSubject.value[indexPath.row].book.isbn
                self.viewModel.action.accept(.swipeToDeleteBook(isbn: isbn))
            }.disposed(by: disposeBag)

        deleteAllButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                if self.viewModel.state.myBooksSubject.value.isEmpty {
                    self.showAlert("책을 추가 해주세요")
                } else {
                    self.viewModel.action.accept(.deleteAllButtonTapped)
                }
            }.disposed(by: disposeBag)

        viewModel.state.deleteAllSuccess
            .subscribe(onNext: { [weak self] in
                self?.showAlert("전체 삭제 완료")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self?.viewModel.action.accept(.fetchAllMyBooks)
                }
            }).disposed(by: disposeBag)
    }

    // MARK: - Layout Helper

    private func configureLayout() {
        tableView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.directionalVerticalEdges.equalToSuperview()
        }
    }

    // MARK: - Delegate Helper

    private func configureDelegate() {
        tableView.delegate = self
    }
}

extension MyBookViewController {

    // MARK: - Methods

    private func configureNavigationItem() {
        self.navigationItem.title = "담은 책"
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
    }

    private func configureBarButtonItem() {
        let leftBarButton = UIBarButtonItem(customView: deleteAllButton)
        self.navigationItem.leftBarButtonItem = leftBarButton

        let rightBarButton = UIBarButtonItem(customView: addBookButton)
        self.navigationItem.rightBarButtonItem = rightBarButton

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .white

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    private func showAlert(_ title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let close = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(close)
        self.present(alert, animated: true, completion: nil)
    }
}
