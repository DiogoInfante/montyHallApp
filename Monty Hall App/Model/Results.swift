//
//  Results.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 30/10/21.
//

import Foundation

/// Models historical game results and statistics
class Results {

    // MARK: - Properties

    private(set) var wins: Int = 0
    private(set) var rounds: Int = 0
    private(set) var switches: Int = 0
    private(set) var keeps: Int = 0
    private(set) var winningRate: Double = 0

    // MARK: - Result Aggregation

    /// Adds a single game result and updates aggregate metrics
    /// - Parameters:
    ///   - win: `true` if the round resulted in a win, `false` otherwise
    ///   - secondChoice: Strategy chosen (`.switchDoor` or `.keepDoor`)
    func addResult(win: Bool, _ secondChoice: SecondChoice) {
        rounds += 1
        if secondChoice == .switchDoor {
            switches += 1
        } else {
            keeps += 1
        }
        if win {
            wins += 1
        }
        winningRate = Double(wins) / Double(rounds)
    }
}

