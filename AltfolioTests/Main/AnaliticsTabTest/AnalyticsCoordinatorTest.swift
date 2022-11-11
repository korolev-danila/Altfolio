//
//  AnalyticsCoordinatorTest.swift
//  AltfolioTests
//
//  Created by Данила on 11.11.2022.
//

import XCTest
@testable import Altfolio

class AnalyticsCoordinatorTest: XCTestCase {

    var sup: AnalyticsCoordinator!
    
    override func setUpWithError() throws {
        sup = AnalyticsCoordinator()
        sup.start()
    }

    override func tearDownWithError() throws {
        sup = nil 
    }

    func testViewModelNotNil() throws {
        XCTAssertNotNil(sup.viewModel)
    }
    
    func testPortfolioViewNotNil() throws {
        XCTAssertNotNil(sup.analyticsView)
    }

}
