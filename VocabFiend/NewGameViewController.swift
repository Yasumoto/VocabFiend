//
//  NewGameViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import GameKit

class NewGameViewController: UIViewController, GKTurnBasedMatchmakerViewControllerDelegate {
    @IBOutlet weak var EntryTitle: UILabel!
    @IBOutlet weak var definition: UITextView!
    @IBOutlet weak var partOfSpeech: UILabel!
    @IBOutlet weak var guessedDefinition: UITextField!
    
    var choice : Entry?
    var randomIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        randomIndex = getRandomIndex()
        choice = wordList[randomIndex]
        EntryTitle.text = choice?.word
        definition.text = choice?.definition
        partOfSpeech.text = choice?.partOfSpeech
    }

    @IBAction func createdDefinition(sender: UITextField) {
        var request : GKMatchRequest = GKMatchRequest()
        request.minPlayers = 2
        request.maxPlayers = 2
        
        var mmvc : GKTurnBasedMatchmakerViewController = GKTurnBasedMatchmakerViewController.init(matchRequest: request);
        mmvc.turnBasedMatchmakerDelegate = self;
        
        println("Made a guess! \(sender.text)")
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

        let submission = Submission(correctWord: choice!, userInputDefinition: self.guessedDefinition.text)
        match.endTurnWithNextParticipants([otherPlayer!, match.currentParticipant], turnTimeout: NSTimeInterval(oneWeek), matchData: submission.encodeData(), completionHandler: { (error) in println("We've finished ending the turn. NSError: \(error)"); viewController.dismissViewControllerAnimated(true, completion: nil) })
    }
    
    func turnBasedMatchmakerViewControllerWasCancelled(viewController: GKTurnBasedMatchmakerViewController!) {
        println("GK controller was cancelled. \(viewController)")
        viewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, didFailWithError error: NSError!) {
        println("FAILURE: \(error)")
        viewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func turnBasedMatchmakerViewController(viewController: GKTurnBasedMatchmakerViewController!, playerQuitForMatch match: GKTurnBasedMatch!) {
        println("Welp. we had someone quit match: \(match)")
        viewController.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
}
