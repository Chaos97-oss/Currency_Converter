//
//  ConverterView.swift
//  Currency_Converter
//
//  Created by Chaos on 10/6/25.
//

import Foundation
import SwiftUI

struct ConverterView: View {
    @StateObject private var viewModel = ConverterViewModel()
    @State private var showChart = false   // <-- navigation trigger
    let sampleData = [
        CurrencyRate(base: "EUR", target: "USD", rate: 1.09, date: Date().addingTimeInterval(-86400 * 3)),
        CurrencyRate(base: "EUR", target: "USD", rate: 1.10, date: Date().addingTimeInterval(-86400 * 2)),
        CurrencyRate(base: "EUR", target: "USD", rate: 1.11, date: Date().addingTimeInterval(-86400 * 1)),
        CurrencyRate(base: "EUR", target: "USD", rate: 1.13, date: Date())
    ]


    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack(spacing: 20) {
                // ---- HEADER ----
                HStack {
                    // Left: Hamburger menu
                    Menu {
                        // Dropdown option(s)
                        Button {
                            showChart = true
                        } label: {
                            Label("Charts", systemImage: "chart.line.uptrend.xyaxis")
                        }

                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .font(.title2)
                            .foregroundColor(.green)
                            .padding(.trailing, 4)
                    }

                    Text("Currency\nCalculator.")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color.blue)

                    Spacer()

                    Button("Sign up") {}
                        .foregroundColor(Color.green)
                        .font(.system(size: 16, weight: .medium))
                }
                .padding(.horizontal)

                // ---- MAIN CARD ----
                VStack(spacing: 20) {
                    TextField("Amount", text: $viewModel.inputAmount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    HStack {
                        Picker("From", selection: $viewModel.baseCurrency) {
                            Text("EUR").tag("EUR")
                            Text("USD").tag("USD")
                            Text("GBP").tag("GBP")
                        }
                        .pickerStyle(.menu)

                        Image(systemName: "arrow.left.arrow.right")
                            .foregroundColor(.gray)
                            .padding(.horizontal, 8)

                        Picker("To", selection: $viewModel.targetCurrency) {
                            Text("PLN").tag("PLN")
                            Text("NGN").tag("NGN")
                            Text("USD").tag("USD")
                        }
                        .pickerStyle(.menu)
                    }

                    Button {
                        Task { await viewModel.convert() }
                    } label: {
                        Text("Convert")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }

                    if viewModel.isLoading {
                        ProgressView()
                    } else if !viewModel.result.isEmpty {
                        Text("\(viewModel.result) \(viewModel.targetCurrency)")
                            .font(.title)
                            .bold()
                            .foregroundColor(.black)
                    }

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                            .font(.caption)
                    }

                    Text("Mid-market exchange rate at 13:38 UTC")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.top, 40)
        }
        // Navigation destination (takes user to chart view)
        .navigationDestination(isPresented: $showChart) {
            RateChartView(data: sampleData)
        }
    }
}
