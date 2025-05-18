//
//  BookRepository.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift

protocol BookRepository {
    func fetchSearchResult(query: String) -> Single<[BookEntity]>
    func saveMyBook(_ receivedBook: BookEntity) -> Bool
    func fetchMyBooks() -> Single<[MyBookEntity]>
    func deleteAllMyBooks() -> Completable
    func deleteBook(isbn: String) -> Completable
    func addRecentBook(_ book: BookEntity) -> Completable
    func fetchRecentBooks() -> Observable<[BookEntity]>
}
