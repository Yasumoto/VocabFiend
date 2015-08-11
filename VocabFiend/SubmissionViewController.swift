//
//  NewGameViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import GameKit

public class SubmissionViewController: UIViewController, GKTurnBasedMatchmakerViewControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var firstEntry: UIButton!
    @IBOutlet weak var secondEntry: UIButton!
    @IBOutlet weak var thirdEntry: UIButton!

    @IBOutlet weak var storyTextView: UITextView!

    var firstWord: Entry?
    var secondWord: Entry?
    var thirdWord: Entry?
    var story: String?
    public var matchData: [Submission]?
    var currentMatch: GKTurnBasedMatch?
    
    public func partOfExistingMatch() -> Bool {
        return matchData != nil
    }

    let saveForLater = "\(NSBundle.mainBundle().resourcePath!)/ToSubmitSoon"

    public override func viewDidLoad() {
        super.viewDidLoad()
        storyTextView.delegate = self

        if story == nil {
            var entries = pickEntries(3)
            firstWord = entries.removeFirst()
            secondWord = entries.removeFirst()
            thirdWord = entries.removeFirst()
            self.storyTextView.editable = true
        } else {
            self.storyTextView.text = story
            self.storyTextView.editable = false
            self.navigationItem.rightBarButtonItem = nil
        }
        firstEntry.setTitle(String(firstWord!.word), forState: UIControlState.Normal)
        secondEntry.setTitle(String(secondWord!.word), forState: UIControlState.Normal)
        thirdEntry.setTitle(String(thirdWord!.word), forState:UIControlState.Normal)
    }

    public override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let entryDisplay = segue.destinationViewController as! EntryDisplayPopoverController
        let word = sender as! UIButton
        if segue.identifier == "wordOne" {
            entryDisplay.entry = firstWord
        } else if segue.identifier == "wordTwo" {
            entryDisplay.entry = secondWord
        } else {
            entryDisplay.entry = thirdWord
        }
    }

    func completeNewTurnInCurrentMatch(match: GKTurnBasedMatch) {
        var otherPlayer: GKTurnBasedParticipant? = nil
        for item in match.participants {
            if let player = item as? GKTurnBasedParticipant {
                if player != match.currentParticipant {
                    otherPlayer = player
                }
            }
        }
        let oneWeek = 60.0 * 60.0 * 24.0 * 7.0

        let submission = Submission(firstWord: firstWord!, secondWord: secondWord!, thirdWord: thirdWord!, story: self.storyTextView.text)

        var data: NSData
        if partOfExistingMatch() {
            matchData!.append(submission)
            data = NSKeyedArchiver.archivedDataWithRootObject(matchData!)
        } else {
            data = NSKeyedArchiver.archivedDataWithRootObject([submission])
        }
        match.endTurnWithNextParticipants([otherPlayer!, match.currentParticipant], turnTimeout: NSTimeInterval(oneWeek), matchData: data, completionHandler: endGKMatchTurn)
    }

    @IBAction func createdDefinition(sender: UIBarButtonItem) {
        if partOfExistingMatch() {
            if let match = currentMatch {
                completeNewTurnInCurrentMatch(match)
            } else {
                println("We should have had a match to append to. Instead had \(currentMatch)")
            }
        } else {
            var request: GKMatchRequest = GKMatchRequest()
            request.minPlayers = 2
            request.maxPlayers = 2

            var mmvc: GKTurnBasedMatchmakerViewController = GKTurnBasedMatchmakerViewController.init(matchRequest: request);
            mmvc.showExistingMatches = false
            mmvc.turnBasedMatchmakerDelegate = self;
            self.presentViewController(mmvc, animated:true, completion:nil)
        }

        println("Story written: \(storyTextView.text)")
    }

    // MARK: - GKTurnBasedMatchmakerViewControllerDelegate

    func endGKMatchTurn(error: NSError!) {
        println("We've finished ending the turn.")
        if error != nil {
            if error.code == GKErrorCode.TurnBasedInvalidTurn.rawValue {
                println("Not the user's turn to play")
            } else {
                println("\(error)")
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }

    public func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, didFindMatch match: GKTurnBasedMatch!) {
        println("Found a match!")
        completeNewTurnInCurrentMatch(match)
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }

    public func turnBasedMatchmakerViewControllerWasCancelled(viewController: GKTurnBasedMatchmakerViewController!) {
        println("GK controller was cancelled.")
        viewController.dismissViewControllerAnimated(true, completion: nil)

    }

    public func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, didFailWithError error: NSError!) {
        println("FAILURE: \(error)")
        viewController.dismissViewControllerAnimated(true, completion: nil)
    }

    public func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, playerQuitForMatch match: GKTurnBasedMatch!) {
        println("Welp. we had someone quit match)")
        viewController.dismissViewControllerAnimated(true, completion: nil)

    }

    // MARK: - Text View Delegate

    public func textViewShouldEndEditing(textView: UITextView) -> Bool {
        storyTextView.resignFirstResponder()
        return true
    }

    public func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == "Enter your wonderful story here!" {
            textView.text = ""
        }
    }

}
