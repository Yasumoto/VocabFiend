//
//  NewGameViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import GameKit

class NewGameViewController: UIViewController, GKTurnBasedMatchmakerViewControllerDelegate, UITextViewDelegate {
    @IBOutlet weak var firstEntry: UIButton!
    @IBOutlet weak var firstEntryPartOfSpeech: UILabel!
    @IBOutlet weak var firstEntryDefinition: UITextView!
    
    @IBOutlet weak var secondEntry: UIButton!
    @IBOutlet weak var secondEntrypartOfSpeech: UILabel!
    @IBOutlet weak var secondEntryDefinition: UITextView!
    
    @IBOutlet weak var thirdEntry: UIButton!
    @IBOutlet weak var thirdEntryPartOfSpeech: UILabel!
    @IBOutlet weak var thirdEntryDefinition: UITextView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var storyTextView: UITextView!
    
    var firstWord : Entry?
    var secondWord : Entry?
    var thirdWord : Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyTextView.delegate = self
        
        var randomIndex = 0

        randomIndex = getRandomIndex()
        firstWord = wordList[randomIndex]
        firstEntry.titleLabel!.text = firstWord?.word
        firstEntryDefinition.text = firstWord?.definition
        firstEntryPartOfSpeech.text = firstWord?.partOfSpeech
        
        randomIndex = getRandomIndex()
        secondWord = wordList[randomIndex]
        secondEntry.titleLabel!.text = secondWord?.word
        secondEntryDefinition.text = secondWord?.definition
        secondEntrypartOfSpeech.text = secondWord?.partOfSpeech

        randomIndex = getRandomIndex()
        thirdWord = wordList[randomIndex]
        thirdEntry.titleLabel!.text = thirdWord?.word
        thirdEntryDefinition.text = thirdWord?.definition
        thirdEntryPartOfSpeech.text = thirdWord?.partOfSpeech
    }

    @IBAction func createdDefinition(sender: UIButton) {
        var request : GKMatchRequest = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        var mmvc : GKTurnBasedMatchmakerViewController = GKTurnBasedMatchmakerViewController.init(matchRequest: request);
        mmvc.turnBasedMatchmakerDelegate = self;
        
        println("Made a story! \(storyTextView.text)")
        self.presentViewController(mmvc, animated:true, completion:nil)
    }
    
    // MARK: - GKTurnBasedMatchmakerViewControllerDelegate
    
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
        let data = NSKeyedArchiver.archivedDataWithRootObject(submission)
        match.endTurnWithNextParticipants([otherPlayer!, match.currentParticipant], turnTimeout: NSTimeInterval(oneWeek), matchData: data, completionHandler: { (error) in println("We've finished ending the turn. NSError: \(error)"); viewController.dismissViewControllerAnimated(true, completion: nil) })
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
