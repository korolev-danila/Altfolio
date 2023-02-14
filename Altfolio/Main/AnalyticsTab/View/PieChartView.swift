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
                ForEach(0..<viewModel.pieArr.count, id: \.self) { index in
                    Circle()
                        .trim(from: index == 0 ? 0.0 : viewModel.pieArr[index-1].value/100,
                              to: viewModel.pieArr[index].value/100)
                        .stroke(Color(red: viewModel.pieArr[index].r, green: viewModel.pieArr[index].g,
                                      blue: viewModel.pieArr[index].b), lineWidth: 100)
                        .scaleEffect(index == indexOfTappedSlice ? 1.1 : 1.0)
                        .animation(.spring(), value: show)
                }
            }.frame(width: 100, height: 200)
            
            ForEach(0..<viewModel.pieArr.count, id: \.self) { index in
                HStack {
                    Text(viewModel.pieArr[index].symbol)
                    Text(String(format: "%.2f", Double(viewModel.pieArr[index].percent))+"%")
                        .font(indexOfTappedSlice == index ? .headline : .subheadline)
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color(red: viewModel.pieArr[index].r, green: viewModel.pieArr[index].g,
                                    blue: viewModel.pieArr[index].b))
                        .frame(width: 15, height: 15)
                }.onTapGesture {
                    indexOfTappedSlice = indexOfTappedSlice == index ? -1 : index
                    self.show.toggle()
                }
            }
            .padding(8)
            .frame(width: 300, alignment: .trailing)
        }
        .onAppear {
            viewModel.fetchMyCoins()
            self.viewModel.calc()
            self.show.toggle()
        }
    }
}
