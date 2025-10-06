//
//  CurrencyRate.swift
//  Currency_Converter
//
//  Created by Chaos on 10/6/25.
//

import Foundation

struct CurrencyRate: Codable, Identifiable {
    var id = UUID()
    let base: String
    let target: String
    let rate: Double
    let date: Date
}
