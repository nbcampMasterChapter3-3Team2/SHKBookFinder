//
//  MyBookViewModel.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import RxSwift
import RxRelay

enum MyBookAction {
    case viewDidLoad
}

struct MyBookState {
    var myBooks = BehaviorRelay<[BookEntity]>(value: [])
}

final class MyBookViewModel: ViewModelType {

    // MARK: - Properties

    var action = PublishRelay<MyBookAction>()
    var state = MyBookState()
    private let disposeBag = DisposeBag()

    // MARK: - Initializer, Deinit, requiered

    init() {
        configureAction()
    }

    // MARK: - Methods

    private func configureAction() {
        action.bind { [weak self] action in
            switch action {
            case .viewDidLoad:
                print("view did load !!")

                // TODO: fetchAllMyBooks
                // TODO: myBooks.accept([BookEntity])
            }
        }
    }
}
