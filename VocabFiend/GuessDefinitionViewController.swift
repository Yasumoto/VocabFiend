//
//  GuessDefinitionViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit

class GuessDefinitionViewController: UIViewController {
    @IBOutlet weak var wordOne: UIButton!
    @IBOutlet weak var wordTwo: UIButton!
    @IBOutlet weak var wordThree: UIButton!
    @IBOutlet weak var definitionTextView: UITextView!
    
    var correctWord = ""
    var submission : Submission?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Probably a good spot for some hip map or something
        var alternates = [Entry]()
        while alternates.count != 2 {
            let newRandom = getRandomIndex()
            let potentialWord = wordList[newRandom]
            if potentialWord.word != correctWord {
                alternates.append(potentialWord)
            }
        }
        
        definitionTextView.text = submission?.userInputDefinition
        wordOne.setTitle(alternates[0].word, forState: UIControlState.Normal)
        wordTwo.setTitle(alternates[1].word, forState: UIControlState.Normal)
        wordThree.setTitle(submission?.correctWord?.word, forState: UIControlState.Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
