//
//  DefaultBookUseCase.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift

final class DefaultBookUseCase: BookUseCase {

    // MARK: - Properties

    private let bookRepository: BookRepository

    // MARK: - Initializer, Deinit, requiered

    init(bookRepository: BookRepository) {
        self.bookRepository = bookRepository
    }

    // MARK: - Methods

    func fetchSearchResult(query: String) -> Observable<[BookEntity]> {
        bookRepository.fetchSearchResult(query: query).asObservable()
    }
}
