//
//  BookResponseMapper.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import Foundation

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
            salePrice: Int(coreData.sale_price),
            thumbnail: coreData.thumbnail,
            status: coreData.status
        )
    }
}
