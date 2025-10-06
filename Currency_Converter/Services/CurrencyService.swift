//
//  CurrencyService.swift
//  Currency_Converter
//
//  Created by Chaos on 10/6/25.
//

import Foundation

class CurrencyService {
    func fetchRate(from base: String, to target: String) async throws -> Double {
        let urlString = "https://api.exchangerate.host/convert?from=\(base)&to=\(target)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)
        let decoded = try JSONDecoder().decode(ExchangeResponse.self, from: data)
        return decoded.result
    }
}

struct ExchangeResponse: Codable {
    let result: Double
}
