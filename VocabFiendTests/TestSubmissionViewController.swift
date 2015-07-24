//
//  TestSubmissionViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 7/24/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import XCTest

class TestSubmissionViewController: XCTestCase {
    var testController: SubmissionViewController?

    override func setUp() {
        testController = SubmissionViewController()
    }

    func testPartOfExistingMatch() {
        if let controller = testController {
            assert(!controller.partOfExistingMatch(), "Match should not be started by default")
            controller.matchData = [Submission()]
            assert(controller.partOfExistingMatch(), "Match data should now be present")
        } else {
            assertionFailure("Controller not created")
        }
    }

}
