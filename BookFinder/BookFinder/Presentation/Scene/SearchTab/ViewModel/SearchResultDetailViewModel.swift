//
//  SearchResultDetailViewModel.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

import RxSwift
import RxRelay

final class SearchResultDetailViewModel: ViewModelDelegate {

    // MARK: - typealias

    enum DetailViewAction {
        case bindSelectedBook(BookEntity)
    }

    struct DetailViewState {
        var bindedBookSubject = BehaviorRelay<BookEntity?>(value: nil)
    }

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    var action = PublishRelay<DetailViewAction>()
    var state = DetailViewState()

    // MARK: - Initializer, Deinit, requiered

    init() {
        configureAction()
    }

    // MARK: - Methods

    private func configureAction() {
        action.bind { [weak self] action in
            guard let self else { return }
            switch action {
            case .bindSelectedBook(let book):
                state.bindedBookSubject.accept(book)
            }
        }
    }

}
