//
//  RateChartView.swift
//  Currency_Converter
//
//  Created by Chaos on 10/6/25.
//

import Foundation
import SwiftUI
import Charts

struct RateChartView: View {
    let data: [CurrencyRate]

    var body: some View {
        VStack {
            Text("Exchange Rate Chart")
                .font(.title2)
                .bold()
                .padding()

            Chart(data) { rate in
                LineMark(
                    x: .value("Date", rate.date),
                    y: .value("Rate", rate.rate)
                )
            }
            .frame(height: 250)
            .padding()

            Spacer()
        }
        .navigationTitle("Charts")
        .navigationBarTitleDisplayMode(.inline)
    }
}
