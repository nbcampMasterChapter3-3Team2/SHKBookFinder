//
//  MetaResponse.swift
//  BookFinder
//
//  Created by kingj on 5/13/25.
//

struct MetaResponse: Decodable {

    // MARK: - Properties

    let totalCount: Int
    let pageableCount: Int
    let isEnd: Bool

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case pageableCount = "pageable_count"
        case isEnd = "is_end"
    }

    // MARK: - Initializer, Deinit, requiered

    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.totalCount = try container.decode(Int.self, forKey: .totalCount)
        self.pageableCount = try container.decode(Int.self, forKey: .pageableCount)
        self.isEnd = try container.decode(Bool.self, forKey: .isEnd)
    }
}
