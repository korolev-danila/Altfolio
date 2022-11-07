//
//  DetailsView.swift
//  Altfolio
//
//  Created by Данила on 07.11.2022.
//

import SwiftUI

struct DetailsView: View {
    
    var viewModel: DetailsViewModel
    
    
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }
    
    var saveCoin: () -> () = { }
    private func save() {
        saveCoin()
    }
    
    var popDetails: () -> () = { }
    private func pop() {
        popDetails()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                DetailsCell(object: viewModel.coin)
                HStack(spacing: 20.0) {
                    Button(action: save) {
                        Text(" Remove ")
                    }
                    Button(action: save) {
                        Text("Add")
                    }
                }
                Spacer()
                Button(action: save) {
                    Text("Delete coin")
                }
            }.padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading ) {
                        Button(action: pop) {
                            Label("%%%%", systemImage: "chevron.left")
                                .font(.title)
                        }
                    }
                }
        }
    }
}

//var vm = DetailsViewModel(coin: Coin(id: "1", name: "Bincoin", symbol: "BTC", logoUrl: "", amount: 1.0, price: 23103.0) )
//
//struct DetailsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        DetailsView(viewModel: vm )
//    }
//}

