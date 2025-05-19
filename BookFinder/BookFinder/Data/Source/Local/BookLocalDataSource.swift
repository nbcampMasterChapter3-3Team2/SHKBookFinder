//
//  BookLocalDataSource.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import CoreData
import RxSwift

final class BookLocalDataSource {

    // MARK: - Properties

    private let persistenceController: PersistenceController

    private let mapper = BookResponseMapper.shared

    // MARK: - Initializer, Deinit, requiered

    init(
        persistenceController: PersistenceController
    ) {
        self.persistenceController = persistenceController
    }

    // MARK: - Methods

    func saveMyBook(_ receivedBook: BookEntity) -> Bool {
        let context = persistenceController.context

        // isbn으로 Book 엔티티가 이미 존재하는지 확인
        let bookFetch: NSFetchRequest<Book> = Book.fetchRequest()
        bookFetch.predicate = NSPredicate(format: "isbn == %@", receivedBook.isbn)

        do {
            let bookResults = try context.fetch(bookFetch)
            let now = Date()

            if let existingBook = bookResults.first {
                // Book을 참조하는 MyBook 이 존재하는지 확인
                let myBookFetch: NSFetchRequest<MyBook> = MyBook.fetchRequest()
                myBookFetch.predicate = NSPredicate(format: "book == %@", existingBook)

                let myBookResults = try context.fetch(myBookFetch)

                if let existingMyBook = myBookResults.first {
                    // MyBook이 존재시 -> saveAt만 UPDATE
                    existingMyBook.savedAt = now
                } else {
                    // Book은 있지만 MyBook에 없음 -> 새 MyBook CREATE
                    let newMyBook = MyBook(context: context)
                    newMyBook.book = existingBook
                    newMyBook.savedAt = now
                }
            } else {
                // Book이 없음 -> 새 Book + 새 MyBook CREATE
                let newBook: Book = mapper.map(from: receivedBook, context: context)
                let newMyBook = MyBook(context: context)
                newMyBook.book = newBook
                newMyBook.savedAt = now
            }

            try context.save()
            return true
        } catch {
            print("[Error] \(CoreDataError.saveFail)")
            return false
        }
    }

    func fetchMyBooks() -> Single<[MyBookEntity]> {
        Single.create { [weak self] observer in
            guard let self else {
                observer(.failure(CoreDataError.unknowned))
                return Disposables.create()
            }

            let context = persistenceController.context
            let request: NSFetchRequest<MyBook> = MyBook.fetchRequest()
            request.sortDescriptors = [
                NSSortDescriptor(key: "savedAt", ascending: false)
            ]

            do {
                let entityResult = try context.fetch(MyBook.fetchRequest())
                let dtoResult = entityResult
                    .map { self.mapper.map(from: $0) }
                observer(.success(dtoResult))
            } catch {
                observer(.failure(CoreDataError.fetchFail))
            }

            return Disposables.create()
        }
    }

    func deleteAllMyBooks() -> Completable {
        Completable.create { [weak self] completable in
            guard let self else {
                completable(.error(CoreDataError.unknowned))
                return Disposables.create()
            }

            let context = persistenceController.context
            let fetchRequest: NSFetchRequest<NSFetchRequestResult> = MyBook.fetchRequest()
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try context.execute(deleteRequest)
                try context.save()
                completable(.completed)
            } catch {
                completable(.error(CoreDataError.deleteFail))
            }
            return Disposables.create()
        }
    }

    func deleteBook(isbn: String) -> Completable {
        Completable.create { [weak self] completable in
            guard let self else {
                completable(.error(CoreDataError.unknowned))
                return Disposables.create()
            }

            let context = persistenceController.context
            let request: NSFetchRequest<MyBook> = MyBook.fetchRequest()
            request.predicate = NSPredicate(format: "book.isbn == %@", isbn)

            do {
                let results = try context.fetch(request)
                results.forEach { context.delete($0) }
                try context.save()
                completable(.completed)
            } catch {
                completable(.error(CoreDataError.deleteFail))
            }
            return Disposables.create()
        }
    }

    func addRecentBook(_ book: BookEntity) -> Completable {
        Completable.create { [weak self] completable in
            guard let self else {
                completable(.error(CoreDataError.unknowned))
                return Disposables.create()
            }

            let now = Date()
            let context = persistenceController.context

            // 동일한 ISBN이 있는지 확인
            let fetchRequest: NSFetchRequest<RecentlyViewedBook> = RecentlyViewedBook.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "book.isbn == %@", book.isbn)

            do {
                let results = try context.fetch(fetchRequest)

                let entity: RecentlyViewedBook

                if let existing = results.first {
                    // 이미 존재하는 경우 -> 업데이트
                    entity = existing
                } else {
                    // 존재하지 않으면 새로 생성
                    entity = RecentlyViewedBook(context: context)
                    entity.book = mapper.map(from: book, context: context)
                }

                // viewedAt 갱신
                entity.viewedAt = now

                try context.save()
                completable(.completed)

            } catch {
                completable(.error(CoreDataError.saveFail))
            }

            return Disposables.create()
        }
    }

    func fetchRecentBooks() -> Observable<[BookEntity]> {
        Observable.create { [weak self] observer in
            guard let self else {
                observer.onError(CoreDataError.unknowned)
                return Disposables.create()
            }

            let context = persistenceController.context
            let request: NSFetchRequest<RecentlyViewedBook> = RecentlyViewedBook.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: "viewedAt", ascending: false)]
            request.fetchLimit = 10

            do {
                let result = try context.fetch(request)
                let entities = result.compactMap { [weak self] book -> BookEntity? in
                    guard let self else { return nil }
                    return mapper.map(from: book)
                }
                observer.onNext(entities)
                observer.onCompleted()
            } catch {
                observer.onError(CoreDataError.fetchFail)
            }

            return Disposables.create()
        }
    }
}
