//
//  AppDelegate.swift
//  VocabFiend
//
//  Created by Joseph Smith on 3/15/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import Crashlytics
import Fabric
import Realm
import RealmSwift
import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication,
            didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics()])
        setSchemaVersion(2, realmPath: Realm.defaultPath, migrationBlock: { migration, oldSchemaVersion in
            if oldSchemaVersion < 2 {
                migration.enumerate(Entry.className()) { oldEntry, newEntry in
                    let word = oldEntry!["word"] as! String
                    let partOfSpeech = oldEntry!["partOfSpeech"] as! String
                    let definition = oldEntry!["definition"] as! String
                    newEntry!["word"] = "\(word)"
                    newEntry!["partOfSpeech"] = "\(partOfSpeech)"
                    newEntry!["definition"] = "\(definition)"
                }
            }
        })

        return true
    }
}

