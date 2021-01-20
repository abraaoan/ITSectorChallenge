//
//  GoogleBookdUITests.swift
//  GoogleBookdUITests
//
//  Created by Abraao Nascimento on 16/01/21.
//  Copyright © 2021 ITSector. All rights reserved.
//

import XCTest

class GoogleBookdUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPaging() {
        
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["search"]

        wait(forElement: searchTextField, timeout: 5)
        
        app.keys["c"].tap()
        app.keys["o"].tap()
        app.keys["f"].tap()
        app.keys["f"].tap()
        app.keys["e"].tap()
        app.keys["e"].tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Go"]/*[[".keyboards",".buttons[\"go\"]",".buttons[\"Go\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        sleep(4)
        
        let collectionView = app.collectionViews.element
        
        collectionView.swipeUp()
        sleep(1)
        collectionView.swipeUp()
        sleep(1)
        collectionView.swipeUp()
        sleep(1)
        collectionView.swipeUp()
        sleep(1)
        collectionView.swipeUp()
        sleep(1)
        
    }

    func testDetailNavigation() {
        
        let app = XCUIApplication()
        app.launch()
        
        let searchTextField = app.textFields["search"]
        wait(forElement: searchTextField, timeout: 5)
        
        app.keys["i"].tap()
        app.keys["o"].tap()
        app.keys["s"].tap()
        
        app/*@START_MENU_TOKEN@*/.buttons["Go"]/*[[".keyboards",".buttons[\"go\"]",".buttons[\"Go\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        sleep(4)
        
        let collectionViews = app.collectionViews
        let cell = collectionViews.children(matching: .cell).element(boundBy: 6)
        cell.tap()
        
        sleep(4)
        
        let closeButton = app.buttons["close"]
        closeButton.tap()
        
        sleep(2)
        
    }
    
}

extension XCTestCase {
    func wait(forElement element: XCUIElement, timeout: TimeInterval) {
        let predicate = NSPredicate(format: "exists == 1")

        // This will make the test runner continously evalulate the
        // predicate, and wait until it matches.
        expectation(for: predicate, evaluatedWith: element)
        waitForExpectations(timeout: timeout)
    }
}
