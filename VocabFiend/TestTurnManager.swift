//
//  TestTurnManager.swift
//  VocabFiend
//
//  Created by Joseph Smith on 5/30/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import XCTest

class TestTurnManager: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testAuthenticateLocalPlayer() {
        // This is an example of a functional test case.
        func handler (viewController: UIViewController!, error: NSError!) -> Void {
            println("\(viewController)")
            println("\(error)")
        }
        var player = authenticateLocalPlayer(handler)
        XCTAssert(player.authenticated, "We need the local player to be authenticated")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }

}
