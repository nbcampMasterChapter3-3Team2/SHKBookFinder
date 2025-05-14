//
//  BookResponseMapper.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

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
}
