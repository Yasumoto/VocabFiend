//
//  Submission.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/8/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import Foundation

class Submission {
    var firstWord : Entry?
    var secondWord : Entry?
    var thirdWord : Entry?
    var story : String?
    
    func encodeData() -> NSData {
        var data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(story, forKey: "story")
        archiver.encodeObject(firstWord?.word, forKey: "firstWord")
        archiver.encodeObject(firstWord?.definition, forKey: "firstDefinition")
        archiver.encodeObject(firstWord?.partOfSpeech, forKey: "firstpartOfSpeech")
        
        archiver.encodeObject(secondWord?.word, forKey: "secondWord")
        archiver.encodeObject(secondWord?.definition, forKey: "secondDefinition")
        archiver.encodeObject(secondWord?.partOfSpeech, forKey: "secondpartOfSpeech")

        archiver.encodeObject(thirdWord?.word, forKey: "thirdWord")
        archiver.encodeObject(thirdWord?.definition, forKey: "thirdDefinition")
        archiver.encodeObject(thirdWord?.partOfSpeech, forKey: "thirdpartOfSpeech")

        archiver.finishEncoding()
        return data as NSData
    }
    
    convenience init(data: NSData) {
        let keyedUnarchiver = NSKeyedUnarchiver(forReadingWithData: data)
        let story = keyedUnarchiver.decodeObjectForKey("story") as! String
        
        let firstWord = keyedUnarchiver.decodeObjectForKey("firstWord") as! String
        let firstDefinition = keyedUnarchiver.decodeObjectForKey("firstDefinition") as! String
        let firstPartOfSpeech = keyedUnarchiver.decodeObjectForKey("firstPartOfSpeech") as! String

        let secondWord = keyedUnarchiver.decodeObjectForKey("secondWord") as! String
        let secondDefinition = keyedUnarchiver.decodeObjectForKey("secondDefinition") as! String
        let secondPartOfSpeech = keyedUnarchiver.decodeObjectForKey("secondPartOfSpeech") as! String
        
        let thirdWord = keyedUnarchiver.decodeObjectForKey("thirdWord") as! String
        let thirdDefinition = keyedUnarchiver.decodeObjectForKey("thirdDefinition") as! String
        let thirdPartOfSpeech = keyedUnarchiver.decodeObjectForKey("thirdPartOfSpeech") as! String
        
        let firstEntry = Entry(word: firstWord, partOfSpeech: firstPartOfSpeech, definition: firstPartOfSpeech)
        let secondEntry = Entry(word: secondWord, partOfSpeech: secondPartOfSpeech, definition: secondPartOfSpeech)
        let thirdEntry = Entry(word: thirdWord, partOfSpeech: thirdPartOfSpeech, definition: thirdPartOfSpeech)
        
        self.init(firstWord: firstEntry, secondWord: secondEntry, thirdWord: thirdEntry, story: story)
    }
    
    init(firstWord: Entry, secondWord: Entry, thirdWord: Entry, story: String) {
        self.story = story
        self.firstWord = firstWord
        self.secondWord = secondWord
        self.thirdWord = thirdWord
    }
}