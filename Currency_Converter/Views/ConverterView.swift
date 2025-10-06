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
        VStack(spacing: 20) {
            HStack {
                Text("Currency Calculator.")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
                Spacer()
                Button("Sign up") {}
                    .foregroundColor(.green)
            }

            VStack(spacing: 16) {
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
                }

                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                }
            }
            .padding()

            Spacer()
        }
        .padding()
    }
}
