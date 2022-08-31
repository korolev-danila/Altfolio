//
//  AddCoinView.swift
//  Altfolio
//
//  Created by Данила on 28.08.2022.
//

import SwiftUI

struct AddCoinView: View {
    
    @ObservedObject var viewModel: AddCoinViewModel
    
    var popAddCoin: () -> () = { }
    private func pop() {
        popAddCoin()
    }
    
    var pushSearch: () -> () = { }
    private func pushModal() {
        pushSearch()
    }
    
    
    var body: some View {
        NavigationView {
            VStack {
                Text("add new coins to the added ones")
                    .frame(height: 45.0)//.font(.system(11))
                HStack {
                    Image("btcLogo")
                        .resizable()
                        .frame(width: 45.0, height: 45.0)
                        .clipShape(Circle())
                        .padding(.leading, 5)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                    Text("\(viewModel.ticker)")
                        .font(.system(size: 22.0))
                    Text("Bitcoin")
                        .font(.system(size: 12.0))
                    Spacer()
                    Image(systemName: "chevron.down")
                        .padding(.trailing, 5.0)
                }
                .frame(height: 45.0)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.gray, lineWidth: 1)
                )
                .onTapGesture {
                    pushModal()
                }
                TextField("add amount", text: $viewModel.count)
                    .frame(height: 45.0)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Add Coin")
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading ) {
                            Button(action: pop) {
                                Label("Add Item", systemImage: "chevron.left")
                                    .font(.title)
                            } //.padding(1.0)
                        }
                    }
                Spacer()
                Button(action: pop) {
                    Text("Accept")
                }
                .frame(height: 35.0)
            }.padding()
        }
        
    }
}

struct AddCoinView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoinView(viewModel: AddCoinViewModel())
    }
}