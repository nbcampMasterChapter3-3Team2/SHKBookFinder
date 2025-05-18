//
//  SearchTabViewModel.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift
import RxRelay

final class SearchTabViewModel: ViewModelType {

    enum Action {
        case viewDidLoad
        case searchBookButtonTapped(String)
        case bookResultCellTapped(BookEntity)
    }

    struct State {
        let bookResultSubject = BehaviorRelay<[BookEntity]>(value: [])
        let selectedBookSubject = PublishRelay<BookEntity>()
        let collectionViewSection = BehaviorRelay<[Section]>(value: [.searchResult])
        let recentBooksSubject = BehaviorRelay<[BookEntity]>(value: [])
    }

    // MARK: - Properties

    private let bookUseCase: BookUseCase
    private let disposeBag = DisposeBag()
    var action = PublishRelay<Action>()
    var state = State()

    // MARK: - Initializer, Deinit, requiered

    init(
        bookUseCase: BookUseCase
    ) {
        self.bookUseCase = bookUseCase
        bindAction()
    }

    // MARK: - Methods

    private func bindAction() {
        action.bind { [weak self] action in
            guard let self else { return }
            switch action {
            case .viewDidLoad:
                fetchRecentBooks()
                configureSection()
            case .searchBookButtonTapped(let query):
                fetchSearchBookResult(quary: query)
            case .bookResultCellTapped(let book):
                bookResultCellTapped(book)
                configureSection()
            }
        }.disposed(by: disposeBag)
    }

    private func configureSection() {
        var result: [Section] = []
        if !state.recentBooksSubject.value.isEmpty {
            result.append(.recentlyViewedBook)
        }
        result.append(.searchResult)

        state.collectionViewSection.accept(result)
    }

    private func fetchRecentBooks() {
        bookUseCase.fetchRecentBooks()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] books in
                guard let self else { return }
                state.recentBooksSubject.accept(books)
            }).disposed(by: disposeBag)
    }

    private func bookResultCellTapped(_ book: BookEntity) {
        // 선택된 셀의 BookEntity 업데이트
        state.selectedBookSubject.accept(book)

        // recentlyViewedBook Section 데이터 업데이트
        //   1. 선택된 셀의 BookEntity -> CoreData 에 추가
        //   2. update 된 모든 최근 본 책 fetch
        bookUseCase.addRecentBook(book)
            .andThen(bookUseCase.fetchRecentBooks())
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] books in
                guard let self else { return }
                state.recentBooksSubject.accept(books)
            }).disposed(by: disposeBag)
    }

    private func fetchSearchBookResult(quary: String) {
        bookUseCase.fetchSearchResult(query: quary)
            .subscribe { [weak self] books in
                guard let self else { return }
                state.bookResultSubject.accept(books)
            }.disposed(by: disposeBag)
    }
}
