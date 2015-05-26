//
//  EntryDisplayPopoverController.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/27/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import UIKit

class EntryDisplayPopoverController: UIViewController {
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var definitionLabel: UITextView!
    var entry: Entry?

    override func viewDidLoad() {
        wordLabel.text = entry!.word
        partOfSpeechLabel.text = entry!.partOfSpeech
        definitionLabel.text = entry!.definition
    }
}
