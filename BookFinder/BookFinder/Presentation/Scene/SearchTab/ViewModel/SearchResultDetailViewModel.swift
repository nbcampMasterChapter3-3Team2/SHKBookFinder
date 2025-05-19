//
//  SearchResultDetailViewModel.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

import RxSwift
import RxRelay

// MARK: - Action & State

enum DetailViewAction {
    case bindSelectedBook(BookEntity)
    case closeTapped
    case addTapped
}

struct DetailViewState {
    let bindedBookSubject = BehaviorRelay<BookEntity?>(value: nil)
}

final class SearchResultDetailViewModel: ViewModelType {

    // MARK: - Properties

    var action = PublishRelay<DetailViewAction>()
    var state = DetailViewState()
    private let disposeBag = DisposeBag()

    weak var delegate: SearchResultDetailViewModelDelegate?

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
            case .bindSelectedBook(let book):
                state.bindedBookSubject.accept(book)
            case .closeTapped:
                self.delegate?.didRequestDismiss()
            case .addTapped:
                guard let book = state.bindedBookSubject.value else { return}
                let result = bookUseCase.saveMyBook(book)

                self.delegate?.didTapAddBook(result)
            }
        }
    }

}
