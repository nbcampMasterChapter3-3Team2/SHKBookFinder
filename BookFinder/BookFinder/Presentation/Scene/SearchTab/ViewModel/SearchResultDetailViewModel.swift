//
//  SearchResultDetailViewModel.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

import RxSwift

final class SearchResultDetailViewModel: ViewModelDelegate {

    // MARK: - typealias

    typealias Action = DetailAction
    typealias State = DetailState

    // MARK: - Properties

    var action: ((Action) -> Void)?
    var disposeBag = DisposeBag()

    var selectedBook = PublishSubject<BookEntity>()

    // MARK: - Initializer, Deinit, requiered

    init() {
        action = configureAction()
    }

    // MARK: - Methods

    private func configureAction() -> ((Action) -> Void) {
        { [weak self] action in
            guard let self else { return }
            switch action {
            case .bindSelectedBook(let book):
                selectedBook.onNext(book)
            }
        }
    }

}
