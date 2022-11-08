//
//  DetailsView.swift
//  Altfolio
//
//  Created by Данила on 07.11.2022.
//

import SwiftUI

struct DetailsView: View {
    
    @ObservedObject var viewModel: DetailsViewModel
    
    @State private var presentAlert = false
    @State private var addOrRemove = true
    var arr = [Coin]()
    
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        
        arr = [viewModel.coin,viewModel.coin,viewModel.coin]
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
            
            VStack(spacing: 0) {
                DetailsCell(object: viewModel.coin)
                
                VStack(spacing: 10) {
                    TextField("  add amount", text: $viewModel.value)
                        .keyboardType(.numberPad)
                        .contentShape(Rectangle())
                        .frame(width: 216 ,height: 40.0)
                        .padding(4)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.gray, lineWidth: 1)
                        )

                    HStack(spacing: 20) {
                        Button {
                            if Double(viewModel.value) != nil {
                                print(viewModel.value)
                                viewModel.saveValue(addBool: true)
                            }

                        } label: {
                            Text("Add")
                                .font(.title2)
                                .bold()
                                .frame(width: 100 , height: 40, alignment: .center)
                        }
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)

                        Button {
                            if Double(viewModel.value) != nil {
                                print(viewModel.value)
                                viewModel.saveValue(addBool: false)
                            }

                        } label: {
                            Text("Remove")
                                .font(.title2)
                                .bold()
                                .frame(width: 100 , height: 40, alignment: .center)
                        }
                        .background(Color.red)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    }
                }.padding()
                
                ScrollView() {
                    VStack{
                        Text("History transaction")
                        ForEach(arr) { coin in
                            DetailsCell(object: coin)
                        }
                    }.padding(.bottom, 30)
                    
                        Button {
                            presentAlert = true
                        } label: {
                            Text("Delete coin")
                                .foregroundColor(Color.red)
                        }
                    
                }
            }
                
            
                .alert("Warning", isPresented: $presentAlert, actions: {
                    
                    Button("Accept", action: {
                        print($viewModel.value)
                    })
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("You will delete the coin and its entire history")
                })
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading ) {
                        Button(action: pop) {
                            Label("%%%%", systemImage: "chevron.left")
                                .font(.title)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                
        }
       
//
//

    }
}

//var coinCD = CoinCD()
//var vm = DetailsViewModel(coin: Coin(id: "1", name: "Bincoin", symbol: "BTC", logoUrl: "", amount: 1.0, price: 23103.0), coinCD: coinCD )
//
//
//struct DetailsView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        DetailsView(viewModel: vm )
//    }
//}
