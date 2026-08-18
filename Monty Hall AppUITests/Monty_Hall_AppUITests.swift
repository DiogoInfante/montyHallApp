//
//  Monty_Hall_AppUITests.swift
//  Monty Hall AppUITests
//
//  Created by Diogo Infante on 16/02/21.
//

import XCTest

class MontyHallAppUITests: XCTestCase {

    // MARK: - Setup & Teardown

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    // MARK: - UI Tests

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

