//
//  MyBookViewModel.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import RxSwift
import RxRelay

enum MyBookAction {
    case fetchAllMyBooks
}

struct MyBookState {
    var myBooks = BehaviorRelay<[MyBookEntity]>(value: [])
}

final class MyBookViewModel: ViewModelType {

    // MARK: - Properties

    var action = PublishRelay<MyBookAction>()
    var state = MyBookState()
    private let disposeBag = DisposeBag()
    private let bookUseCase: BookUseCase

    // MARK: - Initializer, Deinit, requiered

    init(
        bookUseCase: BookUseCase
    ) {
        self.bookUseCase = bookUseCase
        configureAction()
    }

    // MARK: - Methods

    private func configureAction() {
        action.bind { [weak self] action in
            guard let self else { return }
            switch action {
            case .fetchAllMyBooks:
                fetchMyBooks()
            }
            // TODO: myBooks.accept([BookEntity])
        }
    }

    private func fetchMyBooks() {
        bookUseCase.fetchMyBooks()
            .subscribe { [weak self] books in
                guard let self else { return }
                state.myBooks.accept(books)
            }.disposed(by: disposeBag)
    }
}
