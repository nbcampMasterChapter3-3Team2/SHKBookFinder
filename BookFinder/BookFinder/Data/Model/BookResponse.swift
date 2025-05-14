//
//  BookResponse.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import Foundation

struct BookAPIResponse: Decodable {

    // MARK: - Properties

    let meta: MetaResponse
    let documents: [BookResponse]
}

struct BookResponse: Decodable {

    // MARK: - Properties

    let title: String
    let contents: String
    let url: String
    let isbn: String
    let datetime: String  // Date → String 또는 DateFormatter 별도 처리
    let authors: [String]
    let publisher: String
    let translators: [String]?
    let price: Int
    let salePrice: Int
    let thumbnail: String
    let status: String

    enum CodingKeys: String, CodingKey {
        case title
        case contents
        case url
        case isbn
        case datetime
        case authors
        case publisher
        case translators
        case price
        case salePrice = "sale_price"
        case thumbnail
        case status
    }

    // MARK: - Initializer, Deinit, requiered

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.contents = try container.decode(String.self, forKey: .contents)
        self.url = try container.decode(String.self, forKey: .url)
        self.isbn = try container.decode(String.self, forKey: .isbn)
        self.datetime = try container.decode(String.self, forKey: .datetime)
        self.authors = try container.decode([String].self, forKey: .authors)
        self.publisher = try container.decode(String.self, forKey: .publisher)
        self.translators = try container.decodeIfPresent([String].self, forKey: .translators)
        self.price = try container.decode(Int.self, forKey: .price)
        self.salePrice = try container.decode(Int.self, forKey: .salePrice)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.status = try container.decode(String.self, forKey: .status)
    }
}
