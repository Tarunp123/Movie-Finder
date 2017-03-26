//
//  Movie_FinderUITests.swift
//  Movie FinderUITests
//
//  Created by Tarun Prajapati on 21/03/17.
//  Copyright © 2017 Tarun Prajapati. All rights reserved.
//

import XCTest

class Movie_FinderUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    
    
    //MARK:- Automated Movie Search UI Test
    func testMovieSearch(){
        let app = XCUIApplication()
        let searchField = app.textFields["Enter movie or series name"]
        searchField.tap()
        UIPasteboard.generalPasteboard().string = "Logan"
        searchField.pressForDuration(1.1)
        app.menuItems["Paste"].tap()
        app.buttons["Search"].tap()
        app.sheets["What are you looking for?"].collectionViews.buttons["Movie"].tap()
        app.navigationBars["Details"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
    }
    
    //MARK:- Automated Series Search UI Test
    func testSerialSearch(){
        let app = XCUIApplication()
        let searchField = app.textFields["Enter movie or series name"]
        searchField.tap()
        UIPasteboard.generalPasteboard().string = "Dexter"
        searchField.pressForDuration(1.1)
        app.menuItems["Paste"].tap()
        app.buttons["Search"].tap()
        app.sheets["What are you looking for?"].collectionViews.buttons["Series"].tap()
        app.tables.staticTexts["Season 3"].tap()
        app.tables.staticTexts["3. The Lion Sleeps Tonight"].tap()
        app.navigationBars["Details"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.navigationBars["Episodes"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        app.navigationBars["Seasons"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
    }
    
}
