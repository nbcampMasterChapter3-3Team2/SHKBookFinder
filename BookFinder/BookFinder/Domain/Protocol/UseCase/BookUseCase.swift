//
//  BookUseCase.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift

protocol BookUseCase {
    func fetchSearchResult(query: String) -> Observable<[BookEntity]>
    func saveMyBook(_ receivedBook: BookEntity) -> Bool
    func fetchMyBooks() -> Single<[MyBookEntity]>
    func deleteAllMyBooks() -> Completable
    func deleteBook(isbn: String) -> Completable
    func addRecentBook(_ book: BookEntity) -> Completable
    func fetchRecentBooks() -> Observable<[BookEntity]>
}
