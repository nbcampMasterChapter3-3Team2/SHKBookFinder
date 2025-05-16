//
//  BookEntity.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import Foundation

struct BookEntity {
    let title: String
    let contents: String
    let url: String
    let isbn: String
    let datetime: String
    let authors: [String]
    let publisher: String
    let translators: [String]?
    let price: Int
    let salePrice: Int
    let thumbnail: String
    let status: String
}
