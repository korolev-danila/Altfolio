//
//  MainCoordinatorTest.swift
//  AltfolioTests
//
//  Created by Данила on 22.10.2022.
//

import XCTest
@testable import Altfolio

class MainCoordinatorTest: XCTestCase {

    var sup: MainCoordinator!
    
    override func setUpWithError() throws {
        sup = MainCoordinator()
        sup.start()
    }

    override func tearDownWithError() throws {
        sup = nil
    }

    func testValueChildCoordinator() throws {
        XCTAssertEqual(sup.childCoordinator.count, 2)
    }
}
