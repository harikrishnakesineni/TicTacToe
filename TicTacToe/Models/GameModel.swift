//
//  GameModel.swift
//  TicTacToe
//
//  Created by Hari krishna on 23/06/23.
//

import Foundation
import SwiftUI

enum GameType {
    case single, bot, peer, undetermined
    
    
    var description: String {
        switch self {
        case .single:
            return "Share your iPhone/iPad and play against a friend"
        case .bot:
            return "play against this phone/ipad"
        case .peer:
            return "invite someone who has this app to play"
        case .undetermined:
            return ""
        }
    }
}

enum GamePiece: String {
    case x, o
    var image: Image {
        Image(self.rawValue)
    }
    
}

struct Player {
    let gamePlace: GamePiece
    var name: String
    var moves: [Int] = []
    var isCurrent = false
    var isWinner: Bool {
        for moves in Move.winningMoves {
            if moves.allSatisfy(self.moves.contains) {
                return true
            }
        }
        return false
    }
}

enum Move {
    static var all = [1,2,3,4,5,6,7,8,9]
    
    static var winningMoves = [
        [1,2,3],
        [4,5,6],
        [7,8,9],
        [1,4,7],
        [2,5,8],
        [3,6,9],
        [1,5,9],
        [3,5,7]
    ]
    
}
