//
//  DiContainer+ViewModel.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

extension DIContainer {
    func makeSearchTabViewModel() -> SearchTabViewModel {
        SearchTabViewModel(bookUseCase: makeBookUseCase())
    }

    func makeSearchResultDetailViewModel() -> SearchResultDetailViewModel {
        SearchResultDetailViewModel(bookUseCase: makeBookUseCase())
    }

    func makeMyBookViewModel() -> MyBookViewModel {
        MyBookViewModel(bookUseCase: makeBookUseCase())
    }
}
