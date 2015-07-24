//
//  TurnManager.swift
//  VocabFiend
//
//  Created by Joseph Smith on 5/30/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import Foundation
import GameKit
import Realm

struct Match {
    var match : GKTurnBasedMatch
    var currentTurnPlayer : Player {
        get {
            if let currentPlayer = match.currentParticipant.player {
                return Player(player: match.currentParticipant.player)
            }
            else {
                let participant = match.participants.first as! GKTurnBasedParticipant
                return Player(player: participant.player)
            }
        }
    }
    var otherPlayer : Player {
        get {
            return Player(player: match.participants[0].player as GKPlayer)
        }
    }
}

struct Player {
    var player : GKPlayer
    var authenticated : Bool {
        get {
            if let localPlayer = player as? GKLocalPlayer {
                return localPlayer.authenticated
            }
            return false
        }
    }
}

func findMatches(successHandler: (matches: [Match]) -> ()) {
    GKTurnBasedMatch.loadMatchesWithCompletionHandler({ (objects : [AnyObject]!, error : NSError!) -> Void in
        var matches = [Match]()
        if objects != nil {
            for object in objects {
                if let match = object as? GKTurnBasedMatch {
                    matches.append(Match(match: match))
                }
            }
        }
        successHandler(matches: matches)
    })
}

func authenticateLocalPlayer(handler: (UIViewController!, NSError!) -> Void) -> Player {
    let localPlayer = GKLocalPlayer.localPlayer()
    localPlayer.authenticateHandler = handler
    println("Attempting to authenticate: \(localPlayer)")
    return Player(player: localPlayer)
}