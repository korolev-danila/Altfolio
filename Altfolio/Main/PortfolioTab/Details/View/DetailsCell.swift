//
//  DetailsCell.swift
//  Altfolio
//
//  Created by Данила on 07.11.2022.
//

import SwiftUI

struct DetailsCell: View {
    @ObservedObject var object: Coin
    
    var body: some View {
        HStack {
            Spacer()
            AsyncImg(url: object.logoUrl)
            
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Text(object.symbol)
                        .font(.title)
                    Text(object.name)
                }
                Text(removeZerosFromEnd(object.amount))
            }
            Spacer()
            VStack {
                Text("Сoin price:")
                Text(String(format: "%.2f", (object.price)) + "$")
            }
            Spacer()
        }
        .frame( height: 85)
    }
}

struct DetailsCell_Previews: PreviewProvider {
    static var previews: some View {
        DetailsCell(object: Coin(id: "1", name: "Bincoin", symbol: "BTC", logoUrl: "", amount: 1.0, price: 23103.0))
    }
}
