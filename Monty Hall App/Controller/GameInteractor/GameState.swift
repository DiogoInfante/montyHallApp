//
//  GameState.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 30/10/21.
//

import Foundation

/// Available states in the game state machine
enum GameState: Equatable {
    case idle
    case waitingForFirstChoice
    case waitingForSecondChoice
    case ended
}

