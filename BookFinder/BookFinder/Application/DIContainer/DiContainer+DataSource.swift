//
//  DiContainer+DataSource.swift
//  BookFinder
//
//  Created by kingj on 5/14/25.
//

extension DIContainer {
    func makeBookDataSource() -> BookAPIDataSource {
        BookAPIDataSource(apiKey: AppAPIKeys.kakaoAPIKey)
    }

    func makeBookLocalDataSource() -> BookLocalDataSource {
        BookLocalDataSource(persistenceController: persistenceController)
    }
}
