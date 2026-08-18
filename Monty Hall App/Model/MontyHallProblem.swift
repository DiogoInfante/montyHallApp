//
//  MontyHallProblem.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 15/02/21.
//

import Foundation

/// Core game logic model for the Monty Hall problem
class MontyHallProblem {

    // MARK: - Properties

    let numberOfDoors: Int
    private(set) var doors: [Door] = []
    private(set) var prizeDoor: Door = .null
    private(set) var choosenDoor: Door = .null
    private(set) var results = Results()

    // MARK: - Initialization

    init(_ numberOfDoors: Int) {
        self.numberOfDoors = numberOfDoors
        for index in 0..<numberOfDoors {
            doors.append(Door(index))
        }
        addPrize()
    }

    // MARK: - Game Actions

    /// Assigns a prize to a random door
    func addPrize() {
        let prizeDoorId = Int.random(in: 0..<numberOfDoors)
        doors[prizeDoorId].isPrized = true
        self.prizeDoor = doors[prizeDoorId]
    }

    /// Selects the first choice door and reveals goat doors
    /// - Parameter id: ID of the selected door
    func firstChoice(_ id: Int) {
        choosenDoor = doors[id]

        // Host opens non-prized and non-chosen doors
        for door in doors {
            if !door.isPrized && door.id != id {
                door.state = .opened
            }
        }

        // If player picked the prize door, keep one random non-prized door closed
        if id == prizeDoor.id {
            doors[randomNonPrizedDoorSelection(doors).id].state = .closed
        }
    }

    /// Processes the player's second choice (keep vs switch)
    /// - Parameter secondChoice: `.keepDoor` or `.switchDoor`
    /// - Returns: `true` if the choice won the prize, `false` otherwise
    func secondChoice(_ secondChoice: SecondChoice) -> Bool {
        switch secondChoice {
        case .keepDoor:
            if choosenDoor.isPrized {
                results.addResult(win: true, .keepDoor)
                return true
            }
        case .switchDoor:
            if !choosenDoor.isPrized {
                results.addResult(win: true, .switchDoor)
                return true
            }
        }

        results.addResult(win: false, secondChoice)
        return false
    }

    /// Opens all doors to reveal the final outcome
    func openAll() {
        for index in 0..<numberOfDoors {
            doors[index].state = .opened
        }
    }

    /// Returns a random non-prized door from the candidate list
    func randomNonPrizedDoorSelection(_ doors: [Door]) -> Door {
        let eligibleDoors = doors.filter { !$0.isPrized }
        return eligibleDoors[Int.random(in: 0..<eligibleDoors.count)]
    }

    /// Resets the game session for a new round
    func reset() {
        for index in 0..<numberOfDoors {
            doors[index].state = .closed
            doors[index].isPrized = false
        }
        addPrize()
    }

    // MARK: - Query Helpers

    /// Returns IDs of all open doors
    func getOpenIds() -> [Int] {
        let openDoors = self.doors.filter { $0.state == .opened }
        return openDoors.map { $0.id }
    }

    /// Returns the ID of the remaining closed door to switch to
    func getSwitchId() -> Int {
        let closedDoors = self.doors.filter { $0.state == .closed }
        let switchDoor = closedDoors.filter { $0.id != choosenDoor.id }
        return switchDoor.first?.id ?? -1
    }

    /// Returns the ID of the initially chosen door
    func getChoosenId() -> Int {
        return choosenDoor.id
    }
}

