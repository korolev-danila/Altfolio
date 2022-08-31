//
//  ApplicationCoordinator.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import SwiftUI
import UIKit

class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    
    var childCoordinator = [Coordinator]()
    
    init(window: UIWindow) {
        
        self.window = window
    }
    
    func start() {
        
        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        self.childCoordinator = [mainCoordinator]
        self.window.rootViewController = mainCoordinator.rootViewController
    }
}
