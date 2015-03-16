//
//  Submission.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/8/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import Foundation

class Submission : NSObject {
    var correctWord : Entry?
    var userInputDefinition : String?
    
    func encodeData() -> NSData {
        var data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(userInputDefinition, forKey: "userInputDefinition")
        archiver.encodeObject(correctWord?.word, forKey: "correctWord")
        archiver.finishEncoding()
        return data.base64EncodedDataWithOptions(nil)
    }
    
    convenience init(data: NSData) {
        let keyedUnarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        let submission = keyedUnarchiver.decodeObject() as! Submission
        self.init(correctWord: submission.correctWord!, userInputDefinition: submission.userInputDefinition!)
    }
    
    init(correctWord newWord: Entry, userInputDefinition userDefinition: String) {
        correctWord = newWord
        userInputDefinition = userDefinition
    }
}