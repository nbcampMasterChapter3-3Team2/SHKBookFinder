//
//  SearchResultDetailViewModel.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

import RxSwift
import RxRelay

enum DetailViewAction {
    case bindSelectedBook(BookEntity)
    case closeTapped
    case addTapped
}

struct DetailViewState {
    var bindedBookSubject = BehaviorRelay<BookEntity?>(value: nil)
}

final class SearchResultDetailViewModel: ViewModelType {

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    var action = PublishRelay<DetailViewAction>()
    var state = DetailViewState()
    weak var delegate: SearchResultDetailViewModelDelegate?

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
            case .closeTapped:
                self.delegate?.didRequestDismiss()
            case .addTapped:

                // TODO: UseCase 연결 -> 코어데이터 저장
                // TODO: Dismiss

                self.delegate?.didTapAddBook()
            }
        }
    }

}
