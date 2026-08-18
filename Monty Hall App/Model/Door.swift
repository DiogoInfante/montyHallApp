//
//  Door.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 17/02/21.
//

import Foundation

// MARK: - ObserverProtocol

/// Protocol for observing door state and prize changes
protocol ObserverProtocol: AnyObject {
    func stateUpdated(_ newState: DoorState)
    func prizeUpdated(_ isPrized: Bool)
}

// MARK: - Door

/// Door model representing a single door in the Monty Hall problem
class Door {

    // MARK: - Properties

    let id: Int

    var state: DoorState = .closed {
        didSet {
            notifyObserver()
        }
    }

    var isPrized: Bool = false {
        didSet {
            notifyObserver()
        }
    }

    weak var observer: ObserverProtocol?

    static let null = Door(-1)

    // MARK: - Initialization

    init(_ id: Int) {
        self.id = id
    }

    // MARK: - Private Methods

    private func notifyObserver() {
        observer?.stateUpdated(state)
        observer?.prizeUpdated(isPrized)
    }
}

// MARK: - DoorState

/// State of a door (opened or closed)
enum DoorState {
    case opened
    case closed

    /// Toggles the door state between opened and closed
    mutating func toggle() {
        self = (self == .opened) ? .closed : .opened
    }
}

