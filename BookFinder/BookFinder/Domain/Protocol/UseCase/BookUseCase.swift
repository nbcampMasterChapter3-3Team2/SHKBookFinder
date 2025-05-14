//
//  BookUseCase.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import RxSwift

protocol BookUseCase {
    func fetchSearchResult(query: String) -> Single<[BookEntity]>
}
