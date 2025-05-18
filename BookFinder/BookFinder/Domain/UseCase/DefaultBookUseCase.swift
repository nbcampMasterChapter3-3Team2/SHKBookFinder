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

    func saveMyBook(_ receivedBook: BookEntity) -> Bool {
        bookRepository.saveMyBook(receivedBook)
    }

    func fetchMyBooks() -> Single<[MyBookEntity]> {
        bookRepository.fetchMyBooks()
    }

    func deleteAllMyBooks() -> Completable {
        bookRepository.deleteAllMyBooks()
    }

    func deleteBook(isbn: String) -> Completable {
        bookRepository.deleteBook(isbn: isbn)
    }

    func addRecentBook(_ book: BookEntity) -> Completable {
        bookRepository.addRecentBook(book)
    }

    func fetchRecentBooks() -> Observable<[BookEntity]> {
        bookRepository.fetchRecentBooks()
    }
}
