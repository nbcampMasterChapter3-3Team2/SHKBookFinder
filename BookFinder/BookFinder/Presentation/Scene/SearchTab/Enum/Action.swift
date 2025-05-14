//
//  Action.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

enum SearchTapAction {
    case fetchSearchBookResult(String)
}

enum DetailAction {
    case bindSelectedBook(BookEntity)
}
