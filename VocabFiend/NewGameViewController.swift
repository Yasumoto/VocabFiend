//
//  NewGameViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import GameKit

class NewGameViewController: UIViewController, GKTurnBasedMatchmakerViewControllerDelegate, UIScrollViewDelegate, UITextViewDelegate {
    @IBOutlet weak var EntryTitle: UILabel!
    @IBOutlet weak var definition: UITextView!
    @IBOutlet weak var partOfSpeech: UILabel!
    
    @IBOutlet weak var secondEntryLabel: UILabel!
    @IBOutlet weak var secondEntrypartOfSpeech: UILabel!
    @IBOutlet weak var secondEntryDefinition: UITextView!
    
    @IBOutlet weak var thirdEntryLabel: UILabel!
    @IBOutlet weak var thirdEntryPartOfSpeech: UILabel!
    @IBOutlet weak var thirdEntryDefinition: UITextView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var storyTextView: UITextView!
    
    var firstWord : Entry?
    var secondWord : Entry?
    var thirdWord : Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
        scrollView.delegate = self
        scrollView.scrollEnabled = true
        storyTextView.delegate = self
        scrollView.contentSize = CGSizeMake(view.frame.width, view.frame.height)
        
        var randomIndex = 0

        randomIndex = getRandomIndex()
        firstWord = wordList[randomIndex]
        EntryTitle.text = firstWord?.word
        definition.text = firstWord?.definition
        partOfSpeech.text = firstWord?.partOfSpeech
        
        randomIndex = getRandomIndex()
        secondWord = wordList[randomIndex]
        secondEntryLabel.text = secondWord?.word
        secondEntryDefinition.text = secondWord?.definition
        secondEntrypartOfSpeech.text = secondWord?.partOfSpeech

        randomIndex = getRandomIndex()
        thirdWord = wordList[randomIndex]
        thirdEntryLabel.text = thirdWord?.word
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
    
    // MARK: - Keyboard handling
    
    // Call this method somewhere in your view controller setup code.
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name:UIKeyboardDidShowNotification, object:nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillBeHidden:", name: UIKeyboardWillHideNotification, object:nil)
    }
    
    // Called when the UIKeyboardDidShowNotification is sent.
    func keyboardWasShown(aNotification : NSNotification) {
        let info = aNotification.userInfo!
        let kbValue = info[UIKeyboardFrameBeginUserInfoKey] as NSValue
        let kbSize = kbValue.CGRectValue().size
    
        var bkgndRect = sendButton.superview!.frame;
        bkgndRect.size.height += kbSize.height;
        sendButton.superview!.frame = bkgndRect
        scrollView.setContentOffset(CGPointMake(0.0, sendButton.frame.origin.y-kbSize.height), animated:true)
    }
    
    // Called when the UIKeyboardWillHideNotification is sent
    func keyboardWillBeHidden(aNotification: NSNotification) {
        let contentInsets = UIEdgeInsetsZero;
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
    }
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        textViewShouldEndEditing(storyTextView)
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
