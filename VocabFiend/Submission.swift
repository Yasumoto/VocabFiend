//
//  Submission.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/8/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import Foundation
import Realm

class Submission: RLMObject, NSCoding {
    var firstWord: Entry?
    var secondWord: Entry?
    var thirdWord: Entry?
    var story: String = ""
    
    override class func primaryKey() -> String {
        return "story"
    }

    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(story, forKey: "story")
        coder.encodeObject(firstWord!, forKey: "firstWord")
        coder.encodeObject(secondWord!, forKey: "secondWord")
        coder.encodeObject(thirdWord!, forKey: "thirdWord")
    }

    required convenience init(coder decoder: NSCoder) {
        self.init()
        self.story = decoder.decodeObjectForKey("story") as! String
        self.firstWord = decoder.decodeObjectForKey("firstWord") as? Entry
        self.secondWord = decoder.decodeObjectForKey("secondWord") as? Entry
        self.thirdWord = decoder.decodeObjectForKey("thirdWord") as? Entry
    }

    convenience init(firstWord: Entry, secondWord: Entry, thirdWord: Entry, story: String) {
        self.init()
        self.story = story
        self.firstWord = firstWord
        self.secondWord = secondWord
        self.thirdWord = thirdWord
    }
}