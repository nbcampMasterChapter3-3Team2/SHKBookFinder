//
//  BookDataSource.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

import Foundation
import RxSwift

final class BookDataSource {

    // MARK: - Properties

    private let apiKey: String

    // MARK: - Initializer, Deinit, requiered

    init(apiKey: String) {
        self.apiKey = apiKey
    }

    // MARK: - Methods

    func fetchSearchResult(query: String) -> Single<BookAPIResponse> {
        Single.create { [weak self] observer in
            guard let self else {
                observer(.failure(NetworkError.unknowned))
                return Disposables.create()
            }

            let baseUrl = "https://dapi.kakao.com/v3/search/book"

            guard var components = URLComponents(string: baseUrl) else {
                observer(.failure(NetworkError.invalidUrl))
                return Disposables.create()
            }
            components.queryItems = [
                URLQueryItem(name: "target", value: "title"),
                URLQueryItem(name: "query", value: query)
            ]

            guard let url = components.url else {
                observer(.failure(NetworkError.invalidUrl))
                return Disposables.create()
            }

            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("KakaoAK \(apiKey)", forHTTPHeaderField: "Authorization")

            let session = URLSession(configuration: .default)
            session.dataTask(with: request) { data, response, error in
                if let error = error {
                    observer(.failure(error))
                    return
                }

                guard let data = data,
                   let response = response as? HTTPURLResponse,
                   (200..<300).contains(response.statusCode) else {
                    observer(.failure(NetworkError.dataFetchFail))
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(BookAPIResponse.self, from: data)
                    observer(.success(decodedData))
                } catch {
                    observer(.failure(NetworkError.decodingFail))
                }
            }.resume()

            return Disposables.create()
        }
    }
}
