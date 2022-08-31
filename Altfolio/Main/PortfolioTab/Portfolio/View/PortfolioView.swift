//
//  PortfolioView.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import SwiftUI

var btcArr = Array(repeating: btcObj, count: 10)

struct PortfolioView: View {
    
    public var viewModel: PortfolioViewModel
    
    var showAddCoin: () -> () = { }
    
    private func addItem() {
        showAddCoin()
    }
    
    init(viewModel: PortfolioViewModel) {
        self.viewModel = viewModel
    }
    
    init() {
        self.viewModel = PortfolioViewModel()
    }
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading , spacing: 5.0) {
                TotalBalance(balance: 10400)
                    .padding(.leading, 15)
                    .padding(.trailing, 15)
                List() {
                    if #available(iOS 15.0, *) {
                        Text("Tracking list")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .listRowSeparator(.hidden)
                    } else {
                        Text("Tracking list")
                        .frame(maxWidth: .infinity, alignment: .center)                    }
                    ForEach(btcArr, id: \.self) { obj in
                        PortfolioCell(object: obj)
                    }
                }.listStyle( .plain )
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