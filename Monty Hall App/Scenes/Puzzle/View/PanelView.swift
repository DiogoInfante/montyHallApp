//
//  PanelView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 30/10/21.
//

import UIKit

/// Status panel view displaying game instructions, prompts, and score results
class PanelView: AssetView<UILabel> {

    // MARK: - Initialization

    init(_ asset: Asset = .panel) {
        super.init(asset, subView: UILabel())
        self.subView.textAlignment = .center
        self.subView.textColor = .mYellow
        self.subView.numberOfLines = 2
        self.subView.font = UIFont(name: "PhosphateRRSolid", size: 20)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Puzzle View Prompts

    /// Sets panel prompt instructing player to select an initial door
    func tapToChooseADoor() {
        self.subView.text = "Tap to choose a door"
    }

    /// Updates panel prompt asking player whether to keep initial choice or switch doors
    /// - Parameters:
    ///   - openIds: List of opened door zero-indexed IDs
    ///   - chosenId: Chosen door zero-indexed ID
    ///   - switchId: Switch option door zero-indexed ID
    func askForSecondChoice(openIds: [Int], chosenId: Int, switchId: Int) {
        let openString = openIds.increment(1).getString()
        var string = "doors \(openString) has goats"
        if openIds.count == 1 {
            string = "door \(openString) has a goat"
        }
        self.subView.text = "\(string) \nKeep on \(chosenId + 1) or switch to \(switchId + 1)?"
    }

    /// Displays round results and cumulative statistics
    /// - Parameters:
    ///   - didWin: Indicates if the round resulted in a win
    ///   - results: Historical results tracker
    func displayResults(didWin: Bool, results: Results) {
        let lastResult = didWin ? "You've Won!" : "You've Lost..."
        self.subView.text = "\(lastResult)\n Wins:\(results.wins) | rounds: \(results.rounds) | rate: \(Int(results.winningRate * 100))%"
    }

    // MARK: - Experiment View Prompts

    /// Sets panel prompt for experiment setup
    func requestExperiment() {
        self.subView.text = "Select the parameters and slide the lever!"
    }

    /// Displays aggregated results from simulation run
    func displayExperiment(results: Results) {
        self.subView.text = "Wins: \(results.wins) | rounds: \(results.rounds) \nrate: \(String(format: "%.2f", results.winningRate * 100))%"
    }
}

