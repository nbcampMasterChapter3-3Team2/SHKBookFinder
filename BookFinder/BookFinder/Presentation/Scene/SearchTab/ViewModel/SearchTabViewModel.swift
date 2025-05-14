//
//  SearchTabViewModel.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift
import RxCocoa

final class SearchTabViewModel: SearchTabViewModelDelegate {

    // MARK: - typealias

    typealias Action = SearchTapAction
    typealias State = ViewState

    // MARK: - Properties

    var action: ((Action) -> Void)?

    private var stateRelay: BehaviorRelay<ViewState>

    var state: Observable<ViewState> {
        return stateRelay.asObservable()
    }

    private(set) var disposeBag = DisposeBag()

    private let bookUseCase: BookUseCase

    // MARK: - Initializer, Deinit, requiered

    init(
        bookUseCase: BookUseCase
    ) {
        self.bookUseCase = bookUseCase

        stateRelay = BehaviorRelay(
            value:
                ViewState(
                    fetchSearchBook: .idle
                )
        )
        action = configureAction()
    }

    // MARK: - Methods

    private func configureAction() -> ((Action) -> Void) {
        { [weak self] action in
            guard let self else { return }
            switch action {
            case .fetchSearchBookResult(let quary):
                fetchSearchBookResult(quary: quary)
            }
        }
    }

    private func fetchSearchBookResult(quary: String) {
        bookUseCase.fetchSearchResult(query: quary)
            .subscribe { [weak self] result in
                guard let self else { return }
                switch result {
                case .success(let books):
                    // 현재의 ViewState 꺼내기
                    let currentState = stateRelay.value

                    // 필요한 ViewState 상태 변경
                    var newState = currentState
                    newState.fetchSearchBook = .success(books)
                    stateRelay.accept(newState)

                case .failure(let error):
                    let currentState = stateRelay.value

                    var newState = currentState
                    newState.fetchSearchBook = .error(error)

                    stateRelay.accept(newState)

                    print("Error: \(error.localizedDescription)")
                }
        }.disposed(by: disposeBag)
    }
}
