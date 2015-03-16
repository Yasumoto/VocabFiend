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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let sizeOfOptions = UInt32(wordList.count)
        choice = wordList[Int(arc4random_uniform(sizeOfOptions))]
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
        println("GK View Controller: \(viewController)")
        println("match: \(match)")
        // now wat.
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
