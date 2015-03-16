//
//  ViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import GameKit

class ViewController: UITableViewController {
    
    
    var matches = [GKTurnBasedMatch]()
    var localPlayer : GKLocalPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        authenticateLocalPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let match = matches[indexPath.row]
        let participant = match.participants[1] as! GKTurnBasedParticipant
        cell.textLabel!.text = "\(match.status.rawValue) - \(participant.player.alias)"
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            //submissions.removeAtIndex(indexPath.row)
            // TODO(Yasumoto): Will need to do the 'cancel match' logic here
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    
    func playerLoggedIn(localPlayer : GKLocalPlayer) {
        println("The player has been fully logged in!")
        println("Local Player: \(localPlayer)")
        GKTurnBasedMatch.loadMatchesWithCompletionHandler({ (objects : [AnyObject]!, error : NSError!) -> Void in
            for object in objects {
                if let match = object as? GKTurnBasedMatch {
                    println("Match found: \(match)")
                    self.matches.append(match)
                }
            }
            self.tableView.reloadData()
        })
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

