//
//  DiContainer+DataSource.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

extension DIContainer {
    func makeBookDataSource() -> BookDataSource {
        BookDataSource(apiKey: AppAPIKeys.kakaoAPIKey)
    }
}
