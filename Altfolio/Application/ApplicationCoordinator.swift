//
//  ApplicationCoordinator.swift
//  Altfolio
//
//  Created by Данила on 27.08.2022.
//

import UIKit

final class ApplicationCoordinator {
    
    let window: UIWindow
    private var childCoordinator = [CoordinatorProtocol]()
    
    init(window: UIWindow) {
        self.window = window
    }
}

extension ApplicationCoordinator: CoordinatorProtocol {
    func start() {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.start()
        childCoordinator = [mainCoordinator]
        window.rootViewController = mainCoordinator.rootViewController
    }
}
