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
    
    func encodeData() -> NSData {
        var data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(userInputDefinition, forKey: "userInputDefinition")
        archiver.encodeObject(correctWord?.word, forKey: "correctWord")
        archiver.finishEncoding()
        return data as NSData
    }
    
    convenience init(data: NSData) {
        let keyedUnarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        let attemptedUserDef = keyedUnarchiver.decodeObjectForKey("userInputDefinition") as! String
        let word = keyedUnarchiver.decodeObjectForKey("correctWord") as! String
        self.init(correctWord: Entry(word: word, partOfSpeech: "v", definition: "test"), userInputDefinition: attemptedUserDef)
    }
    
    init(correctWord newWord: Entry, userInputDefinition userDefinition: String) {
        correctWord = newWord
        userInputDefinition = userDefinition
    }
}