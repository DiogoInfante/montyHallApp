//
//  Asset.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 30/10/21.
//

import UIKit

/// Enumeration of asset catalog image names used throughout the app
enum Asset: String {
    case empty

    // MARK: - Common Assets

    case background
    case smoothBackground
    case goat
    case car
    case discoOn
    case discoOff
    case pop
    case next
    case back
    case yes
    case no

    // MARK: - Scene Assets

    // Home
    case banner
    case play
    case experiment
    case book

    // Puzzle
    case panel
    case stage
    case choice
    case playAgain
    case door
    case carDoor
    case goatDoor

    // Experiment
    case picker
    case lever
    case rail
    case doorSymbol
    case shuffleSymbol
    case repeatSymbol
    case experimentBoard

    // MARK: - Image Retrieval

    /// Retrieves the `UIImage` corresponding to the asset case
    static func get(_ asset: Asset) -> UIImage {
        guard let image = UIImage(named: asset.rawValue) else {
            return UIImage()
        }
        return image
    }
}

