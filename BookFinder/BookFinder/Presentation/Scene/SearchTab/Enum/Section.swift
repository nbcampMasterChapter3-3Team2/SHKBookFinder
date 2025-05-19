//
//  Section.swift
//  BookFinder
//
//  Created by kingj on 5/12/25.
//

enum Section: Int, CaseIterable {

    // MARK: - Properties

    case recentlyViewedBook
    case searchResult

    var title: String {
        switch self {
        case .recentlyViewedBook: return "최근 본 책"
        case .searchResult: return "검색 결과"
        }
    }
}
