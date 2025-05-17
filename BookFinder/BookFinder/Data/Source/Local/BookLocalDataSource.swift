//
//  BookLocalDataSource.swift
//  BookFinder
//
//  Created by kingj on 5/17/25.
//

import CoreData

final class BookLocalDataSource {

    // MARK: - Properties

    private let persistenceController: PersistenceController

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
                let newBook = Book(context: context)
                newBook.title = receivedBook.title
                newBook.contents = receivedBook.contents
                newBook.url = receivedBook.url
                newBook.isbn = receivedBook.isbn
                newBook.datetime = receivedBook.datetime
                newBook.authors = receivedBook.authors
                newBook.publisher = receivedBook.publisher
                newBook.translators = receivedBook.translators ?? []
                newBook.price = Int32(receivedBook.price)
                newBook.sale_price = Int32(receivedBook.salePrice)
                newBook.thumbnail = receivedBook.thumbnail
                newBook.status = receivedBook.status

                let newMyBook = MyBook(context: context)
                newMyBook.book = newBook
                newMyBook.savedAt = now
            }

            try context.save()
            return true
        } catch {
            print("[Error] \(CoreDataError.unknowned)")
            return false
        }
    }
}
