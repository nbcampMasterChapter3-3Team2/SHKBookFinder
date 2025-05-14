//
//  DiContainer+UseCase.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

extension DIContainer {
    func makeBookUseCase() -> BookUseCase {
        DefaultBookUseCase(bookRepository: makeBookRepository())
    }
}
