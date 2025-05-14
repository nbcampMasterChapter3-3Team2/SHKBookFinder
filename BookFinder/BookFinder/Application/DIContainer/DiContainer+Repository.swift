//
//  DiContainer+Repository.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

extension DIContainer {
    func makeBookRepository() -> BookRepository {
        DefaultBookRepository(bookDataSource: makeBookDataSource())
    }
}
