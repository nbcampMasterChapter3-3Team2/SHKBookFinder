//
//  ViewController.swift
//  BookFinder
//
//  Created by kingj on 5/11/25.
//

import UIKit
import Then
import SnapKit
import RxSwift

final class SearchTabViewController: UIViewController {
    
    // MARK: - Properties

    let viewModel: SearchTabViewModel
    var currentState: ViewState
    var disposeBag = DisposeBag()

    // MARK: - UI Components

    lazy var searchBar = UISearchBar().then {
        $0.placeholder = "책 이름"
        $0.setShowsCancelButton(false, animated: true)
        $0.searchBarStyle = .minimal
    }

    private let collectionView = CollectionView()

    // MARK: - Initializer, Deinit, requiered

    init(
        viewModel: SearchTabViewModel
    ) {
        self.viewModel = viewModel
        self.currentState = ViewState(
            fetchSearchBook: .idle
        )
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configureHierarchy()
        configureLayout()
        configureDelegate()
        configureDataSource()
        dissmissKeyboardTapGesture()
    }

    // MARK: - Hierarchy Helper

    private func configureHierarchy() {
        [
            searchBar,
            collectionView
        ]
            .forEach { view.addSubview($0) }
    }

    // MARK: - Layout Helper

    private func configureLayout() {

        navigationController?.navigationBar.isHidden = true

        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }

        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.directionalHorizontalEdges.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }

    // MARK: - Delegate Helper

    private func configureDelegate() {
        collectionView.collectionView.delegate = self
        searchBar.delegate = self
    }

    // MARK: - DataSource Helper

    private func configureDataSource() {
        collectionView.collectionView.dataSource = self
    }

    // MARK: - Methods

    private func bind() {
        viewModel.state
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in
                guard let self else { return }
                self.currentState = state
                self.collectionView.collectionView.reloadData()
            }).disposed(by: disposeBag)
    }

    private func dissmissKeyboardTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dissmissKeyboard))
        tapGesture.cancelsTouchesInView = false // CollectionView Cell 터치 이벤트 통과 허용
        view.addGestureRecognizer(tapGesture)
    }

    // MARK: - @objc Methods

    @objc
    private func dissmissKeyboard() {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
    }

}
