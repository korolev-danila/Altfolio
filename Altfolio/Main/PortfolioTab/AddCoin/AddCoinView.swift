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
    var saveCoin: () -> () = { }
    private func save() {
        saveCoin()
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
                    AsyncImg(url: viewModel.selected.logoUrl)
                    Text(viewModel.selected.symbol)
                        .font(.system(size: 22.0))
                    Text(viewModel.selected.name)
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
                .contentShape(Rectangle())
                .onTapGesture {
                    pushModal()
                }
                TextField("add amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                    .contentShape(Rectangle())
                    .frame(height: 45.0)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Add Coin")
                Spacer()
                Button(action: save) {
                    Text("Save coin")
                }
                .frame(height: 35.0)
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

struct AddCoinView_Previews: PreviewProvider {
    static var previews: some View {
        AddCoinView(viewModel: AddCoinViewModel())
    }
}
