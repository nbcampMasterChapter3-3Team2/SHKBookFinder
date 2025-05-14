//
//  DefaultBookRepository.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift

final class DefaultBookRepository: BookRepository {

    private let bookDataSource: BookDataSource

    private let mapper = BookResponseMapper.shared

    init(bookDataSource: BookDataSource) {
        self.bookDataSource = bookDataSource
    }

    func fetchSearchResult(query: String) -> Single<[BookEntity]> {
        bookDataSource.fetchSearchResult(query: query)
            .map { [weak self] bookAPIResponse in
                guard let self else { return [] }
                return bookAPIResponse.documents.map { self.mapper.map(from: $0) }
            }
    }
}
