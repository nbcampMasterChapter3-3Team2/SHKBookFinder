//
//  NetworkError.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

enum NetworkError: Error {
    case invalidUrl
    case dataFetchFail
    case decodingFail
    case unknowned
}

enum CoreDataError: Error {
    case saveFail
    case updateFail
    case deleteFail
    case fetchFail
    case unknowned
}
