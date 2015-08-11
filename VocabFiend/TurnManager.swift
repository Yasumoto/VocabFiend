//
//  TurnManager.swift
//  VocabFiend
//
//  Created by Joseph Smith on 5/30/15.
//  Copyright (c) 2015 bjoli. All rights reserved.
//

import Foundation
import GameKit

struct Match {
    var match : GKTurnBasedMatch
    var currentTurnPlayer : Player {
        get {
            if let currentPlayer = match.currentParticipant.player {
                return Player(player: match.currentParticipant.player)
            } else {
                let participant = match.participants.first as! GKTurnBasedParticipant
                return Player(player: participant.player)
            }
        }
    }
    var otherPlayer : Player {
        get {
            var second = GKPlayer()
            for participant in match.participants {
                if let participant = participant as? GKTurnBasedParticipant {
                    if let otherPlayer: GKPlayer = participant.player {
                        if otherPlayer != GKLocalPlayer.localPlayer() {
                            second = otherPlayer
                        }
                    }
                }
            }
            return Player(player: second)
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

func findMatches(successHandler: (matches: [Match]) -> (), noConnectionHandler: () -> ()) {
    GKTurnBasedMatch.loadMatchesWithCompletionHandler({ (objects : [AnyObject]!, error : NSError!) -> Void in
        var matches = [Match]()
        if let matchObjects = objects {
            for object in matchObjects {
                if let match = object as? GKTurnBasedMatch {
                    matches.append(Match(match: match))
                }
            }
        } else {
            noConnectionHandler()
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