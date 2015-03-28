//
//  FullStoryTableViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/27/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import GameKit
import UIKit

class FullStoryTableViewController: UITableViewController {
    
    var match : GKTurnBasedMatch?
    var submissions : [Submission]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        println("Loading matchData for \(match!.matchID)")
        match!.loadMatchDataWithCompletionHandler(updateMatchData)
    }
    
    func updateMatchData(matchData: NSData!, error: NSError!) -> Void {
        submissions = NSKeyedUnarchiver.unarchiveObjectWithData(matchData) as? [Submission]
        self.tableView.reloadData()
        println("We found \(submissions!.count) submissions")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if submissions != nil {
            return submissions!.count
        }
        return 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let submission = submissions![indexPath.row]
        println("Using submission: \(submission)")
        let cell = tableView.dequeueReusableCellWithIdentifier("submission", forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = submission.story
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    //        submission = NSKeyedUnarchiver.unarchiveObjectWithData(matchData) as? Submission
    }
    */

}