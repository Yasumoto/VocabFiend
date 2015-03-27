//
//  ViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UITableViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var refreshGamesButton: UIBarButtonItem!
    @IBOutlet weak var addGameButton: UIBarButtonItem!
    var matches = [GKTurnBasedMatch]()
    var localPlayer : GKLocalPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshGamesButton.enabled = false
        //self.addGameButton.enabled = false
        self.tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        authenticateLocalPlayer()
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
    }

    @IBAction func refreshMatches(sender: UIButton) {
        loadMatches()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "guessDefinition" {
            let guessingController = segue.destinationViewController as GuessDefinitionViewController
            let cell = sender as UITableViewCell
            let index = self.tableView.indexPathForCell(cell)?.row
            guessingController.match = matches[index!]
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        let match = matches[indexPath.row]
        let participant = match.participants[0] as GKTurnBasedParticipant
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        
        cell.textLabel!.text = "\(participant.player.alias)"
        if participant.player.playerID == localPlayer?.playerID {
            cell.textLabel!.textColor = UIColor.grayColor()
        }
        else {
            cell.textLabel!.textColor = UIColor.greenColor()

        }
        cell.detailTextLabel!.text = "\(dateFormatter.stringFromDate(match.creationDate))"
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func matchWasDeleted(error: NSError!) -> Void {
        println("match deleted with error: \(error)")
    
    }
    
    func deleteMatch(tableView: UITableView, indexPath: NSIndexPath) {
        let match = matches[indexPath.row]
        match.removeWithCompletionHandler(matchWasDeleted)
        matches.removeAtIndex(indexPath.row)
        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //submissions.removeAtIndex(indexPath.row)
            // TODO(Yasumoto): Will need to do the 'cancel match' logic here
            deleteMatch(tableView, indexPath: indexPath)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func loadMatches() {
        self.refreshGamesButton.enabled = false

        GKTurnBasedMatch.loadMatchesWithCompletionHandler({ (objects : [AnyObject]!, error : NSError!) -> Void in
            self.matches = [GKTurnBasedMatch]()
            for object in objects {
                if let match = object as? GKTurnBasedMatch {
                    self.matches.append(match)
                }
            }
            self.tableView.reloadData()
            self.refreshGamesButton.enabled = true
        })
    }
    
    func playerLoggedIn(localPlayer : GKLocalPlayer) {
        println("Local Player logged in: \(localPlayer)")
        self.addGameButton.enabled = true
        loadMatches()
    }
    
    func gameKitAuthenticationHandler(viewController : UIViewController!, error: NSError!) -> Void {
        if viewController != nil {
            //showAuthenticationDialogWhenReasonable: is an example method name. Create your own method that displays an authentication view when appropriate for your app.
            println("We're going to try to auth here.")
            self.presentViewController(viewController, animated:true, completion:nil)
        } else if (localPlayer!.authenticated) {
            //authenticatedPlayer: is an example method name. Create your own method that is called after the loacal player is authenticated.
            println("Already authenticated!")
            playerLoggedIn(localPlayer!)
        } else {
            println("Player not logged in! \(error)")
            //disableGameCenter()
        }
    }
    
    // GameKit Auth
    func authenticateLocalPlayer() {
        localPlayer = GKLocalPlayer.localPlayer()
        localPlayer!.authenticateHandler = self.gameKitAuthenticationHandler
        println("Attempting to authenticate: \(localPlayer)")
    }
}

