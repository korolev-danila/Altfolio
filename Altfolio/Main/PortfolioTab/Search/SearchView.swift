//
//  SearchView.swift
//  Altfolio
//
//  Created by Данила on 29.08.2022.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: AddCoinViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "chevron.down")
                .resizable()
                .frame(width: 25.0, height: 8.0, alignment: .center)
                .padding(5.0)
            TextField("add amount", text: $viewModel.count)
                .frame(height: 25.0)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 1)
                )
                .padding(5)
            List(btcArr) { obj in
                PortfolioCell(object: obj)
                    .onTapGesture {
                        print("\(obj)")
                    }
            }.listStyle(PlainListStyle())
            
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: AddCoinViewModel())
    }
}
