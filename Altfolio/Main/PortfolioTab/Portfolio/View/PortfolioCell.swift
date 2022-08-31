//
//  PortfolioCell.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import SwiftUI

let image = UIImage(named: "btcLogo")
let btcObj = Bitcoin(id: 1,
                  ticker: "BTC",
                  name: "Bitcoin",
                  cost: 21200.67,
                  volume: 0.55,
                  imageData: image!.pngData()! )

struct PortfolioCell: View {
    
    var object: Bitcoin
    
    var body: some View {
        HStack {
            Image(uiImage:(UIImage(data: object.imageData) ?? UIImage(named: "btcLogo")! ))
                .resizable()
                .frame(width: 45.0, height: 45.0)
                .clipShape(Circle())
                .padding(.leading, 5)
            
            VStack(alignment: .leading, spacing: 0.0) {
                HStack {
                    Text(object.ticker)
                        .font(.title)
                    Text(object.name)
                }
                Text("\(object.volume)")
            }
            Spacer()
            Text("\(object.cost)")
        }
        .frame( height: 85)
    }
}

struct PortfolioCell_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioCell(object: btcObj)
    }
}
