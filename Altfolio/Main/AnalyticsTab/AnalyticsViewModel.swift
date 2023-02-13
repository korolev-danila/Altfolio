//
//  AnalyticsViewModel.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import Foundation
import SwiftUI

struct ChartData {
    var id = UUID()
    var color : Color
    var percent : CGFloat
    var value : CGFloat
}

final class AnalyticsViewModel: ObservableObject {
    private let coreData: CoreDataProtocol
    
    @Published var chartData =
    [ChartData(color: Color(#colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)), percent: 8, value: 0),
     ChartData(color: Color(#colorLiteral(red: 1, green: 0.8323456645, blue: 0.4732058644, alpha: 1)), percent: 15, value: 0),
     ChartData(color: Color(#colorLiteral(red: 0.4508578777, green: 0.9882974029, blue: 0.8376303315, alpha: 1)), percent: 32, value: 0),
     ChartData(color: Color(#colorLiteral(red: 0.476841867, green: 0.5048075914, blue: 1, alpha: 1)), percent: 13, value: 0)]
    
    init(coreData: CoreDataProtocol) {
        self.coreData = coreData
    }
    
    func calc(){
        var value : CGFloat = 0
        
        for i in 0..<chartData.count {
            value += chartData[i].percent
            chartData[i].value = value
        }
    }
}
