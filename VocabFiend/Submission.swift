//
//  Submission.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/8/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import Foundation

class Submission {
    var correctWord : Entry?
    var userInputDefinition : String?
    var sneakyOptions : [Entry]?
    
    func encodeData() -> NSData {
        return NSKeyedArchiver.archivedDataWithRootObject(self)
    }
    
    convenience init(data: NSData) {
        let data = NSKeyedUnarchiver(forReadingWithData: data)
        let submission = data.decodeObject() as! Submission
        self.init(correctWord: submission.correctWord!, userInputDefinition: submission.userInputDefinition!, sneakyOptions: submission.sneakyOptions!)
    }
    
    init(correctWord newWord: Entry, userInputDefinition userDefinition: String, sneakyOptions alternatives: [Entry]) {
        correctWord = newWord
        userInputDefinition = userDefinition
        sneakyOptions = alternatives
    }
}