//
//  ViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit


class ViewController: UITableViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var refreshGamesButton: UIBarButtonItem!
    @IBOutlet weak var addGameButton: UIBarButtonItem!
    var matches = [Match]()
    
    var localPlayer : Player?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshGamesButton.enabled = false
        //TODO(Yasumoto): Uncomment this when back on the network
        //self.addGameButton.enabled = false
        self.tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
        localPlayer = authenticateLocalPlayer(authenticationHandler)
    }
    
    override func viewDidAppear(animated: Bool) {
        if let player = localPlayer {
            loadMatches()
        }
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textView.text = ""
    }
    
    @IBAction func refreshMatches(sender: UIBarButtonItem) {
        loadMatches()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "viewMatch" {
            let guessingController = segue.destinationViewController as! FullStoryTableViewController
            let cell = sender as! UITableViewCell
            let index = self.tableView.indexPathForCell(cell)?.row
            guessingController.match = matches[index!].match
        } else if segue.identifier == "newMatch" {
            let submissionController = segue.destinationViewController as! SubmissionViewController
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
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
        
        let match = matches[indexPath.row]
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle

        if let alias = match.otherPlayer.player.alias {
            cell.textLabel!.text = "\(alias)"
        } else {
            cell.textLabel!.text = "No partner yet"
        }
        // The goal here is to highlight anywhere that the current player is able to make this their turn.
        // In practice, there's likely a better way to do it.
        if match.currentTurnPlayer.player == localPlayer!.player {
            cell.textLabel!.textColor = UIColor.darkGrayColor()
        }
        else {
            cell.textLabel!.textColor = UIColor.lightGrayColor()

        }
        cell.detailTextLabel!.text = "\(dateFormatter.stringFromDate(match.match.creationDate))"
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
        match.match.removeWithCompletionHandler(matchWasDeleted)
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

    func couldNotFindMatches() -> () {
        print("Could not get any matches when attempting to load them")
    }

    func loadedMatches(matches: [Match]) -> () {
        self.matches = matches
        self.tableView.reloadData()
        self.refreshGamesButton.enabled = true
    }

    func loadMatches() {
        self.refreshGamesButton.enabled = false
        findMatches(loadedMatches, couldNotFindMatches)
    }
    
    func playerLoggedIn(localPlayer : Player) {
        println("Local Player logged in: \(localPlayer)")
        self.addGameButton.enabled = true
        loadMatches()
    }
    
    func authenticationHandler(viewController : UIViewController!, error: NSError!) -> Void {
        if viewController != nil {
            //showAuthenticationDialogWhenReasonable: is an example method name. Create your own method that displays an authentication view when appropriate for your app.
            println("We're going to try to auth here.")
            self.presentViewController(viewController, animated:true, completion:nil)
            return
        } else if let player = localPlayer {
            //authenticatedPlayer: is an example method name. Create your own method that is called after the loacal player is authenticated.
            if player.authenticated {
                println("Already authenticated!")
                playerLoggedIn(localPlayer!)
                return
            }
        } else {
            //disableGameCenter() - the game starts off disabled already. Eventually we'll want to allow read-only mode, which means this will happen here
        }
        println("Player not logged in! \(error)")
    }
}

