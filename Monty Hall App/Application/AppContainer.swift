//
//  AppContainer.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 30/10/21.
//

import Foundation

// MARK: - Factory Protocols

/// Protocol defining creation of HomeVC
protocol HomeVCFactory {
    func makeHomeVC() -> HomeVC
}

/// Protocol defining creation of PuzzleVC
protocol PuzzleVCFactory {
    func makePuzzleVC() -> PuzzleVC
}

/// Protocol defining creation of ExperimentVC
protocol ExperimentVCFactory {
    func makeExperimentVC() -> ExperimentVC
}

/// Protocol defining creation of TutorialVC
protocol TutorialVCFactory {
    func makeTutorialVC() -> TutorialVC
}

// MARK: - AppContainer

/// Dependency injection container for creating view controllers
class AppContainer {}

// MARK: - Factory Conformance

extension AppContainer: HomeVCFactory {
    func makeHomeVC() -> HomeVC {
        return HomeVC(factory: self)
    }
}

extension AppContainer: PuzzleVCFactory {
    func makePuzzleVC() -> PuzzleVC {
        return PuzzleVC()
    }
}

extension AppContainer: ExperimentVCFactory {
    func makeExperimentVC() -> ExperimentVC {
        return ExperimentVC()
    }
}

extension AppContainer: TutorialVCFactory {
    func makeTutorialVC() -> TutorialVC {
        return TutorialVC()
    }
}

