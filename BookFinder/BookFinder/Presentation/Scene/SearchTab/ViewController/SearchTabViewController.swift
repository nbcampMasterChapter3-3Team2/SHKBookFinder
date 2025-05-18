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
import RxCocoa

final class SearchTabViewController: UIViewController {

    // MARK: - Properties

    let searchViewModel: SearchTabViewModel
    let detailViewModel: SearchResultDetailViewModel
    let disposeBag = DisposeBag()

    // MARK: - UI Components

    var searchBar = UISearchBar().then {
        $0.placeholder = "책 이름"
        $0.setShowsCancelButton(false, animated: true)
        $0.searchBarStyle = .minimal
    }

    private let collectionView = SearchCollectionView()

    // MARK: - Initializer, Deinit, requiered

    init(
        searchViewModel: SearchTabViewModel,
        detailViewModel: SearchResultDetailViewModel
    ) {
        self.searchViewModel = searchViewModel
        self.detailViewModel = detailViewModel
        super.init(nibName: nil, bundle: nil)
        bind()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureDelegate()
        configureDataSource()
        searchViewModel.action.accept(.viewDidLoad)
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

    // MARK: - Bind

    private func bind() {
        searchViewModel.state.bookResultSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] books in
                guard let self else { return }
                collectionView.collectionView.reloadData()
            }, onError: { error in
                print("[Error] Search Book Result: \(error)")
            }).disposed(by: disposeBag)

        searchViewModel.state.selectedBookSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] book in
                guard let self else { return }

                let vc = SearchResultDetailViewController(viewModel: detailViewModel)
                detailViewModel.action.accept(.bindSelectedBook(book))
                present(vc, animated: true)
            }, onError: { error in
                print("[Error] Selected Book 전달: \(error)")
            }).disposed(by: disposeBag)

        searchViewModel.state.collectionViewSection
            .subscribe(onNext: { [weak self] sections in
                guard let self else { return }
                collectionView.sections = sections
            }).disposed(by: disposeBag)

        searchViewModel.state.recentBooksSubject
            .subscribe(onNext: { [weak self] recentBooks in
                guard let self else { return }
                collectionView.collectionView.reloadData()
            }).disposed(by: disposeBag)

        searchBar.rx.text
            .orEmpty
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] quary in
                guard let self else { return }
                searchViewModel.action.accept(.searchBookButtonTapped(quary))
            }).disposed(by: disposeBag)

        // TODO: [Refactor] CollectionView Cell - 클릭된 셀의 Book 모델 전송
//        collectionView.collectionView.rx.modelSelected(BookEntity.self)
//            .bind(to: viewModel.selectedBook)
//            .disposed(by: disposeBag)
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
        searchBar.rx.setDelegate(self)
    }

    // MARK: - DataSource Helper

    private func configureDataSource() {
        collectionView.collectionView.dataSource = self
    }

    // MARK: - Methods

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
