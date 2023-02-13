//
//  PieChart.swift
//  Altfolio
//
//  Created by Данила on 13.02.2023.
//

import SwiftUI

struct PieChart: View {
    @ObservedObject private var viewModel: AnalyticsViewModel
    @State private var indexOfTappedSlice = -1
    @State private var show = false
    
    init(viewModel: AnalyticsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            ZStack {
                ForEach(0..<viewModel.chartData.count, id: \.self) { index in
                    Circle()
                        .trim(from: index == 0 ? 0.0 : viewModel.chartData[index-1].value/100,
                              to: viewModel.chartData[index].value/100)
                        .stroke(viewModel.chartData[index].color, lineWidth: 100)
                        .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                        .animation(.spring(), value: show)
                }
            }.frame(width: 100, height: 200)
                .onAppear() {
                    self.viewModel.calc()
                    self.show.toggle()
                }
            ForEach(0..<viewModel.chartData.count, id: \.self) { index in
                HStack {
                    Text(String(format: "%.2f", Double(viewModel.chartData[index].percent))+"%")
                        .onTapGesture {
                            indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                            self.show.toggle()
                        }
                        .font(indexOfTappedSlice == index ? .headline : .subheadline)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(viewModel.chartData[index].color)
                        .frame(width: 15, height: 15)
                }
            }
            .padding(8)
            .frame(width: 300, alignment: .trailing)
        }
    }
}
