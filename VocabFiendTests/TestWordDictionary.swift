//
//  TestWordDictionary.swift
//  VocabFiend
//
//  Created by Joseph Smith on 7/23/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import XCTest

class TestWordDictionary: XCTestCase {
    func testGetRandomIndex() {
        assert(getRandomIndex() > -1, "We should always get a positive index")
    }

    func testPickEntries() {
        let desiredEntries = 3
        assert(pickEntries(desiredEntries).count == desiredEntries,
            "We should retrieve \(desiredEntries) entries")
    }

    func testPerformanceExample() {
        self.measureBlock() {
            pickEntries(500)
        }
    }

}
