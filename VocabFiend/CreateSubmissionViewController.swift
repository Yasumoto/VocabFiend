//
//  NewGameViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import GameKit

enum SubmissionState {
    case New;
    case AddSubmission;
    case View;
}

class CreateSubmissionViewController: UIViewController, GKTurnBasedMatchmakerViewControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var firstEntry: UIButton!
    @IBOutlet weak var secondEntry: UIButton!
    @IBOutlet weak var thirdEntry: UIButton!
    
    @IBOutlet weak var storyTextView: UITextView!
    
    var firstWord : Entry?
    var secondWord : Entry?
    var thirdWord : Entry?
    
    var submissionType : SubmissionState?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyTextView.delegate = self
        
        if submissionType! != SubmissionState.View {
            var randomIndex = 0
            
            randomIndex = getRandomIndex()
            firstWord = wordList[randomIndex]
            
            randomIndex = getRandomIndex()
            secondWord = wordList[randomIndex]
            
            randomIndex = getRandomIndex()
            thirdWord = wordList[randomIndex]
        }
        firstEntry.setTitle(firstWord!.word, forState: UIControlState.Normal)
        secondEntry.setTitle(secondWord!.word, forState: UIControlState.Normal)
        thirdEntry.setTitle(thirdWord!.word, forState:UIControlState.Normal)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let entryDisplay = segue.destinationViewController as EntryDisplayPopoverController
        let word = sender as UIButton
        if segue.identifier == "wordOne" {
            entryDisplay.entry = firstWord
        } else if segue.identifier == "wordTwo" {
            entryDisplay.entry = secondWord
        } else {
            entryDisplay.entry = thirdWord
        }
    }

    @IBAction func createdDefinition(sender: UIBarButtonItem) {
        var request : GKMatchRequest = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        var mmvc : GKTurnBasedMatchmakerViewController = GKTurnBasedMatchmakerViewController.init(matchRequest: request);
        mmvc.turnBasedMatchmakerDelegate = self;
        
        println("Made a story! \(storyTextView.text)")
        self.presentViewController(mmvc, animated:true, completion:nil)
    }
    
    // MARK: - GKTurnBasedMatchmakerViewControllerDelegate
    
    func endGKMatchTurn(error : NSError!) {
        println("We've finished ending the turn. NSError: \(error)")
        if error == nil {
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, didFindMatch match: GKTurnBasedMatch!) {
        println("Found a match!")
        var otherPlayer : GKTurnBasedParticipant? = nil
        for item in match.participants {
            if let player = item as? GKTurnBasedParticipant {
                if player != match.currentParticipant {
                    otherPlayer = player
                }
            }
        }
        let oneWeek = 60.0 * 60.0 * 24.0 * 7.0

        let submission = Submission(firstWord: firstWord!, secondWord: secondWord!, thirdWord: thirdWord!, story: self.storyTextView.text)
        //TODO(Yasumoto): How will you handle appending a new submission to the array?
        let data = NSKeyedArchiver.archivedDataWithRootObject([submission])
        match.endTurnWithNextParticipants([otherPlayer!, match.currentParticipant], turnTimeout: NSTimeInterval(oneWeek), matchData: data, completionHandler: endGKMatchTurn)
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func turnBasedMatchmakerViewControllerWasCancelled(viewController: GKTurnBasedMatchmakerViewController!) {
        println("GK controller was cancelled.")
        viewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, didFailWithError error: NSError!) {
        println("FAILURE: \(error)")
        viewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, playerQuitForMatch match: GKTurnBasedMatch!) {
        println("Welp. we had someone quit match)")
        viewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // MARK: - Text View Delegate
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        storyTextView.resignFirstResponder()
        return true
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == "Enter your wonderful story here!" {
            textView.text = ""
        }
    }
    
}
