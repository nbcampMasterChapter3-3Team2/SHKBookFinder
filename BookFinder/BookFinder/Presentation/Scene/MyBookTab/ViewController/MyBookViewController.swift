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
        $0.backgroundColor = .white
        $0.register(MyBookCell.self, forCellReuseIdentifier: MyBookCell.identifier)
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
        configureDataSource()
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
        viewModel.state.myBooks
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                guard let self else { return }
                tableView.reloadData()
            }, onError: { error in
                print("[Error] MyBook \(error)")
            }).disposed(by: disposeBag)

        deleteAllButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                viewModel.action.accept(.deleteAllButtonTapped)
            }.disposed(by: disposeBag)

        // TODO: 스와이프 삭제
    }

    // MARK: - Layout Helper

    private func configureLayout() {
        tableView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.directionalVerticalEdges.equalToSuperview()
        }


    }

    // MARK: - Delegate Helper

    private func configureDelegate() {
        tableView.delegate = self
    }

    // MARK: - DataSource Helper

    private func configureDataSource() {
        tableView.dataSource = self
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
}
