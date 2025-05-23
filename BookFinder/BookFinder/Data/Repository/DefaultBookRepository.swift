//
//  DefaultBookRepository.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift

final class DefaultBookRepository: BookRepository {

    private let bookDataSource: BookAPIDataSource
    private let bookLocalDataSource: BookLocalDataSource

    private let mapper = BookResponseMapper.shared

    init(
        bookDataSource: BookAPIDataSource,
        bookLocalDataSource: BookLocalDataSource
    ) {
        self.bookDataSource = bookDataSource
        self.bookLocalDataSource = bookLocalDataSource
    }

    func fetchSearchResult(query: String) -> Single<[BookEntity]> {
        bookDataSource.fetchSearchResult(query: query)
            .map { [weak self] bookAPIResponse in
                guard let self else { return [] }
                return bookAPIResponse.documents.map { self.mapper.map(from: $0) }
            }
    }

    func fetchSearchResultByPage(query: String, page: Int) -> Single<(books: [BookEntity], isEnd: Bool)> {
        bookDataSource.fetchSearchResultByPage(query: query, page: page)
            .map { [weak self] response in
                guard let self = self else {
                    return ([], response.meta.isEnd)
                }

                let books: [BookEntity] = response.documents.compactMap { [weak self] book in
                    return self?.mapper.map(from: book)
                }

                return (books, response.meta.isEnd)
            }
    }

    func saveMyBook(_ receivedBook: BookEntity) -> Bool {
        bookLocalDataSource.saveMyBook(receivedBook)
    }

    func fetchMyBooks() -> Single<[MyBookEntity]> {
        bookLocalDataSource.fetchMyBooks()
    }

    func deleteAllMyBooks() -> Completable {
        bookLocalDataSource.deleteAllMyBooks()
    }

    func deleteBook(isbn: String) -> Completable {
        bookLocalDataSource.deleteBook(isbn: isbn)
    }

    func addRecentBook(_ book: BookEntity) -> Completable {
        bookLocalDataSource.addRecentBook(book)
    }

    func fetchRecentBooks() -> Observable<[BookEntity]> {
        bookLocalDataSource.fetchRecentBooks()
    }

}
