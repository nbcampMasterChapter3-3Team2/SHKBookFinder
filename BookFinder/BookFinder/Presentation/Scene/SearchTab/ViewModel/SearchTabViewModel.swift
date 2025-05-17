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
        case searchBookButtonTapped(String)
        case bookResultCellTapped(BookEntity)
    }

    struct State {
        let bookResultSubject = BehaviorRelay<[BookEntity]>(value: [])
        let selectedBookSubject = PublishRelay<BookEntity>()
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
            case .searchBookButtonTapped(let query):
                fetchSearchBookResult(quary: query)
            case .bookResultCellTapped(let book):
                bookResultCellTapped(book)
            }
        }.disposed(by: disposeBag)
    }

    private func bookResultCellTapped(_ book: BookEntity) {
        state.selectedBookSubject.accept(book)
    }

    private func fetchSearchBookResult(quary: String) {
        bookUseCase.fetchSearchResult(query: quary)
            .subscribe { [weak self] books in
                guard let self else { return }
                state.bookResultSubject.accept(books)
            }.disposed(by: disposeBag)
    }
}
