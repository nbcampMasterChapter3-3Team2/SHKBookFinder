//
//  State.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

enum SearchState {
    case idle
    case success([BookEntity])
    case error(Error)
}

struct ViewState {
    var fetchSearchBook: SearchState
}

enum DetailState {
    case selectedBook(BookEntity)
}
