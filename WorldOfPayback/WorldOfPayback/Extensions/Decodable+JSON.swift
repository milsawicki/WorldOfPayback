//
//  Decodable+JSON.swift
//  WorldOfPayback
//
//  Created by Milan Sawicki on 05/03/2023.
//  Copyright © 2023 Loyalty Partner GmbH. All rights reserved.
//

import Foundation

extension Decodable {
    public static var decoder: JSONDecoder {
        let formatter = DateFormatter()
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)

            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            if let date = formatter.date(from: dateString) {
                return date
            }
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: dateString) {
                return date
            }
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Cannot decode date string \(dateString)")
        }
        return decoder
    }

    static func from(localJSON filename: String,
                     bundle: Bundle = .main) throws -> Self {
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            throw JSONParseError.fileNotFound
        }

        return try decoder.decode(self, from: Data(contentsOf: url))
    }
}
