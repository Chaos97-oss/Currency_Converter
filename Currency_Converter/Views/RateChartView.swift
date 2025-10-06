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
        Chart(data) {
            LineMark(
                x: .value("Date", $0.date),
                y: .value("Rate", $0.rate)
            )
            PointMark(
                x: .value("Date", $0.date),
                y: .value("Rate", $0.rate)
            )
        }
        .frame(height: 200)
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}
