//
//  FullStoryTableViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/27/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import GameKit
import UIKit
import Realm

class FullStoryTableViewController: UITableViewController {

    var match: GKTurnBasedMatch?
    var submissions: [Submission]?
    let realm = RLMRealm.defaultRealm()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        submissions = [Submission]()
        let jimmeh = Submission.allObjects()
        for result in jimmeh {
            submissions?.append(result as! Submission)
        }
        println("Loading matchData for \(match!.matchID)")
        match!.loadMatchDataWithCompletionHandler(updateMatchData)
    }

func updateMatchData(matchData: NSData!, error: NSError!) -> Void {
        submissions = NSKeyedUnarchiver.unarchiveObjectWithData(matchData) as? [Submission]
        realm.beginWriteTransaction()
        realm.deleteAllObjects()
        for submission in submissions! {
            Submission.createOrUpdateInDefaultRealmWithObject(submission)

        }
        realm.commitWriteTransaction()
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
        println("Using submission: \(submission.firstWord?.word), \(submission.secondWord?.word), \(submission.thirdWord?.word)")
        let cell = tableView.dequeueReusableCellWithIdentifier("submission", forIndexPath: indexPath)as! UITableViewCell
        cell.textLabel?.text = submission.story
        return cell
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationController = segue.destinationViewController as! SubmissionViewController

        if segue.identifier == "viewEntry" {
            let index = tableView.indexPathForCell(sender as! UITableViewCell)
            let submission = submissions![index!.row]
            //TODO(Yasumoto): Just pass a submission
            destinationController.firstWord = submission.firstWord
            destinationController.secondWord = submission.secondWord
            destinationController.thirdWord = submission.thirdWord
            destinationController.story = submission.story
        } else if segue.identifier == "addEntry" {
            destinationController.matchData = submissions
        }
    }

}
