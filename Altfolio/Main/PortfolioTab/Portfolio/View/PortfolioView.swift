//
//  PortfolioView.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import SwiftUI


struct PortfolioView: View {
    
    @ObservedObject var viewModel: PortfolioViewModel
    
    var showAddCoin: () -> () = { }
    
    var totalValue: Int {
        var total: Double = 0.0
        for coin in viewModel.coins {
            total += coin.price
        }
        return Int(total)
    }
    
    init(viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
    }
    
    init() {
        self.viewModel = PortfolioViewModel()
    }
    
    private func addItem() {
        showAddCoin()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading , spacing: 5.0) {
                TotalBalance(balance: totalValue)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                List() {
                    if #available(iOS 15.0, *) {
                        Text("Tracking list")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .listRowSeparator(.hidden)
                    } else {
                        Text("Tracking list")
                        .frame(maxWidth: .infinity, alignment: .center)  }
                    ForEach(self.viewModel.coins, id: \.self) { obj in
                        PortfolioCell(object: obj)
                    }
                }.listStyle( .plain )
                    .refreshable {
                        viewModel.updatePrice()
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading ) {
                            Text("Porfolio tracker").font(.headline)
                        }
                        ToolbarItem(placement: .navigationBarTrailing ) {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
                                    .font(.title)
                            }.padding(1.0)
                        }
                    }
            }
        }
    }
}

struct PortfolioView_Previews: PreviewProvider {
    
    static var previews: some View {
        PortfolioView()
    }
}
