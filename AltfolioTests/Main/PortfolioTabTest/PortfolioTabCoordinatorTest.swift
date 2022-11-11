//
//  PortfolioTabCoordinatorTests.swift
//  AltfolioTests
//
//  Created by Данила on 22.10.2022.
//

import XCTest
@testable import Altfolio

class PortfolioCoordinatorTest: XCTestCase {

    var sup: PortfolioCoordinator!
    
    override func setUpWithError() throws {
        sup = PortfolioCoordinator()
        sup.start()
    }

    override func tearDownWithError() throws {
        sup = nil
    }

    func testViewModelNotNil() throws {
        XCTAssertNotNil(sup.viewModel)
    }
    
    func testViewModelCoinsMapNotNil() throws {
        XCTAssertNotNil(sup.viewModel.coinsMap)
    }
    
    func testPortfolioViewNotNil() throws {
        XCTAssertNotNil(sup.portfolioView)
    }
}
