//
//  SearchCell.swift
//  Altfolio
//
//  Created by Данила on 01.09.2022.
//

import SwiftUI

var coinMok = Coin(json: ["id" : "1", "name": "Name", "rank": 1, "slug":"bitcoin", "symbol": "BTC"])!
//coinMok.id = "1"
//coinMok.name = "name"
//coinMok.rank = 1
//coinMok.slug = "vfvf"
//coinMok.symbol = "BTC"

struct SearchCell: View {
    
    var coin: Coin
    
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: coin.logoUrl)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .progressViewStyle(.circular)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .padding(.leading, 5)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                case .failure:
                    Text("Failed")
                        .foregroundColor(.red)
                @unknown default:
                    Text("Failed")
                        .foregroundColor(.red)
                }
            }
            .frame(width: 45.0, height: 45.0)
            
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Text(coin.symbol)
                        .font(.title)
                    Text(coin.name)
                }
            }
            Spacer()
        }
        .frame( height: 85)
    }
}

struct SearchCell_Previews: PreviewProvider {
    static var previews: some View {
        SearchCell(coin: coinMok)
    }
}
