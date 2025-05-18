//
//  BookResponseMapper.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import Foundation
import CoreData

struct BookResponseMapper {

    // MARK: - Properties

    static let shared = BookResponseMapper()

    // MARK: - Methods

    func map(from response: BookResponse) -> BookEntity {
        BookEntity(
            title: response.title,
            contents: response.contents,
            url: response.url,
            isbn: response.isbn,
            datetime: response.datetime,
            authors: response.authors,
            publisher: response.publisher,
            translators: response.translators,
            price: response.price,
            salePrice: response.salePrice,
            thumbnail: response.thumbnail,
            status: response.status
        )
    }

    func map(from coreData: MyBook) -> MyBookEntity {
        MyBookEntity(
            book: map(from: coreData.book),
            saveAt: coreData.savedAt
        )
    }

    func map(from coreData: Book) -> BookEntity {
        BookEntity(
            title: coreData.title,
            contents: coreData.contents,
            url: coreData.url,
            isbn: coreData.isbn,
            datetime: coreData.datetime,
            authors: coreData.authors,
            publisher: coreData.publisher,
            translators: coreData.translators,
            price: Int(coreData.price),
            salePrice: Int(coreData.salePrice),
            thumbnail: coreData.thumbnail,
            status: coreData.status
        )
    }

    func map(from book: BookEntity, context: NSManagedObjectContext) -> Book {
        let result = Book(context: context)
        result.title = book.title
        result.contents = book.contents
        result.url = book.url
        result.isbn = book.isbn
        result.datetime = book.datetime
        result.authors = book.authors
        result.publisher = book.publisher
        result.translators = book.translators ?? []
        result.price = Int32(book.price)
        result.salePrice = Int32(book.salePrice)
        result.thumbnail = book.thumbnail
        result.status = book.status
        return result
    }

    func map(from book: BookEntity, context: NSManagedObjectContext) -> RecentlyViewedBook {
        let result = RecentlyViewedBook(context: context)
        result.book.title = book.title
        result.book.contents = book.contents
        result.book.url = book.url
        result.book.isbn = book.isbn
        result.book.datetime = book.datetime
        result.book.authors = book.authors
        result.book.publisher = book.publisher
        result.book.translators = book.translators ?? []
        result.book.price = Int32(book.price)
        result.book.salePrice = Int32(book.salePrice)
        result.book.thumbnail = book.thumbnail
        result.book.status = book.status
        return result
    }

    func map(from book: RecentlyViewedBook) -> BookEntity {
        BookEntity(
            title: book.book.title,
            contents: book.book.contents,
            url: book.book.url,
            isbn: book.book.isbn,
            datetime: book.book.datetime,
            authors: book.book.authors,
            publisher: book.book.publisher,
            translators: book.book.translators,
            price: Int(book.book.price),
            salePrice: Int(book.book.salePrice),
            thumbnail: book.book.thumbnail,
            status: book.book.status
        )
    }
}
