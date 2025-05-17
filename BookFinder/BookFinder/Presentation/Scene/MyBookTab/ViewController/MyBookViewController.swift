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

final class MyBookViewController: UIViewController {

    // MARK: - Properties

    let viewModel: MyBookViewModel
    private let disposeBag = DisposeBag()

    // MARK: - UI Components

    private let tableView = UITableView(frame: .zero, style: .plain).then {
        $0.backgroundColor = .white
        $0.register(MyBookCell.self, forCellReuseIdentifier: MyBookCell.identifier)
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
        viewModel.action.accept(.viewDidLoad)
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

        // TODO: 스와이프 삭제
    }

    // MARK: - Layout Helper

    private func configureLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
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
        let deleteAll = UIButton(type: .system)
        deleteAll.setTitle("전체 삭제", for: .normal)
        deleteAll.setTitleColor(.gray, for: .normal)
        deleteAll.titleLabel?.font = UIFont.systemFont(ofSize: 15)

        // TODO: addTarget > Rx
        deleteAll.addTarget(self, action: #selector(onTappedDeleteAll), for: .touchUpInside)

        let leftBarButton = UIBarButtonItem(customView: deleteAll)
        self.navigationItem.leftBarButtonItem = leftBarButton

        let addBook = UIButton(type: .system)
        addBook.setTitle("추가", for: .normal)
        addBook.setTitleColor(.systemOrange, for: .normal)
        addBook.titleLabel?.font = .boldSystemFont(ofSize: 15)

        // TODO: addTarget > Rx
        addBook.addTarget(self, action: #selector(onTappedAddBook), for: .touchUpInside)

        let rightBarButton = UIBarButtonItem(customView: addBook)
        self.navigationItem.rightBarButtonItem = rightBarButton

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.backgroundColor = .white

        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

    // MARK: - @objc Methods

    @objc
    private func onTappedDeleteAll() {
        print("delete all")
    }

    @objc
    private func onTappedAddBook() {
        print("add book")
    }
}
