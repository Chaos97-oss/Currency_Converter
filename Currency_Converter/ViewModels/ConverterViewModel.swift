//
//  ConverterViewModel.swift
//  Currency_Converter
//
//  Created by Chaos on 10/6/25.
//

import Foundation

@MainActor
class ConverterViewModel: ObservableObject {
    @Published var baseCurrency = "EUR"
    @Published var targetCurrency = "PLN"
    @Published var inputAmount: String = "1"
    @Published var result: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let service = CurrencyService()

    func convert() async {
        guard let amount = Double(inputAmount) else {
            errorMessage = "Invalid amount"
            return
        }
        isLoading = true
        errorMessage = nil
        do {
            let rate = try await service.fetchRate(from: baseCurrency, to: targetCurrency)
            let converted = rate * amount
            result = String(format: "%.4f", converted)
        } catch {
            errorMessage = "Failed to fetch rate"
        }
        isLoading = false
    }
}
