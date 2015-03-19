//
//  GuessDefinitionViewController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit
import GameKit

class GuessDefinitionViewController: UIViewController {

    @IBOutlet weak var storyTextView: UITextView!
    
    @IBOutlet weak var wordOneLabel: UILabel!
    @IBOutlet weak var wordTwoLabel: UILabel!
    @IBOutlet weak var wordThreeLabel: UILabel!
    
    
    var correctWord = ""
    var submission : Submission?
    var match : GKTurnBasedMatch?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        match!.loadMatchDataWithCompletionHandler(updateMatchData)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateMatchData(matchData: NSData!, error: NSError!) -> Void {
        submission = Submission(data: matchData)
    
        storyTextView.text = submission?.story
        wordOneLabel.text = submission?.firstWord?.word
        wordTwoLabel.text = submission?.secondWord?.word
        wordThreeLabel.text = submission?.thirdWord?.word
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
