//
//  StateMachine.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 30/10/21.
//

import Foundation

// MARK: - StateObserver

/// Observer protocol notified when state changes occur in the state machine
protocol StateObserver: AnyObject {
    func changingStateFor(event: GameEvent,
                          from oldState: GameState,
                          to newState: GameState)
}

// MARK: - StateMachine

/// State machine managing gameplay transitions driven by game events
class StateMachine {

    // MARK: - Properties

    private(set) var currentState: GameState = .idle
    weak var delegate: StateObserver?

    // MARK: - Initialization

    init(_ firstState: GameState = .idle) {
        self.currentState = firstState
        debugPrint("Initialized state machine with state: \(currentState)")
    }

    // MARK: - State Transition Logic

    private func changeState(with event: GameEvent, to newState: GameState) {
        guard let observedVC = delegate else { return }
        debugPrint("Event:", event, "State changed from:", currentState, "to:", newState)
        observedVC.changingStateFor(event: event, from: currentState, to: newState)
        currentState = newState
    }

    // MARK: - Event Triggers

    /// Transition from initial state to waiting for first choice
    func start() {
        changeState(with: .start, to: .waitingForFirstChoice)
    }

    /// Record first choice selection
    func madeFirstChoice(_ id: Int) {
        changeState(with: .madeFirstChoice(id), to: .waitingForSecondChoice)
    }

    /// Record second choice selection
    func madeSecondChoice(_ choice: SecondChoice) {
        changeState(with: .madeSecondChoice(choice), to: .ended)
    }

    /// Reset game to initial active state
    func reset() {
        changeState(with: .reset, to: .waitingForFirstChoice)
    }
}

