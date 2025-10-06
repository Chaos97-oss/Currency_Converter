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

    var body: some View {
        ZStack {
            // ---> Plain white background so the blue title is readable
            Color.white
                .ignoresSafeArea()

            VStack(spacing: 20) {
                HStack {
                    Text("Currency\nCalculator.")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(Color.blue)     // blue title visible on white bg
                    Spacer()
                    Button("Sign up") {}
                        .foregroundColor(Color.green)
                        .font(.system(size: 16, weight: .medium))
                }
                .padding(.horizontal)

                // Main Card
                VStack(spacing: 20) {
                    // Amount input
                    TextField("Amount", text: $viewModel.inputAmount)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)

                    // Currency pickers / swap icon
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

                    // Convert button
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

                    // Result / Loading / Error
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

                    // Exchange rate info
                    Text("Mid-market exchange rate at 13:38 UTC")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
                .padding()
                .background(Color.white) // keep card white but separated by shadow
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.08), radius: 10, x: 0, y: 4)
                .padding(.horizontal, 20)

                Spacer()
            }
            .padding(.top, 40)
        }
    }
}
