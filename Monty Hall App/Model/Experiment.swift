//
//  Experiment.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 17/02/21.
//

import Foundation

/// Simulation of n rounds of the Monty Hall problem with a specified door count and strategy
class Experiment {

    // MARK: - Properties

    private(set) var numberOfDoors: Int
    private(set) var rounds: Int
    private(set) var secondChoice: SecondChoice
    private(set) var montyHall: MontyHallProblem

    // MARK: - Initialization

    init(numberOfDoors: Int, secondChoice: SecondChoice, rounds: Int) {
        self.numberOfDoors = numberOfDoors
        self.rounds = rounds
        self.secondChoice = secondChoice
        self.montyHall = MontyHallProblem(numberOfDoors)
    }

    // MARK: - Execution

    /// Runs the simulation for the configured number of rounds
    func run() {
        for _ in 0..<rounds {
            montyHall.firstChoice(Int.random(in: 0..<numberOfDoors - 1))
            _ = montyHall.secondChoice(secondChoice)
            montyHall.openAll()
            montyHall.reset()
        }
    }
}

