//
//  PuzzleView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 16/02/21.
//

import UIKit

/// View laying out doors collection, status panel, control buttons, and stage graphics
class PuzzleView: NavigationView {

    // MARK: - Properties

    let collection = DoorCollectionView()
    let choice = ChoiceView()
    let panel = PanelView()
    let stage = AssetView(.stage)
    let reset = AssetView(.playAgain, subView: UIButton())

    let space = UIScreen.main.bounds.height * 0.03

    // MARK: - Initialization

    init() {
        super.init()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup & Layout

    func setupUI() {
        self.addSubview(collection)
        setupCollectionViewConstraints()

        self.addSubview(panel)
        setupPanelConstraints()

        self.addSubview(stage)
        setupStageConstraints()

        self.addSubview(choice)
        setupChoiceConstraints()
        choice.disappear()

        self.addSubview(reset)
        setupResetConstraints()
        reset.disappear()

        waitingForFirstChoice()
    }

    private func setupCollectionViewConstraints() {
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        collection.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        collection.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.95).isActive = true
        collection.heightAnchor.constraint(equalTo: collection.widthAnchor, multiplier: 0.6).isActive = true
    }

    private func setupPanelConstraints() {
        panel.translatesAutoresizingMaskIntoConstraints = false
        panel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        panel.topAnchor.constraint(equalTo: self.topBar.bottomAnchor).isActive = true
        panel.bottomAnchor.constraint(equalTo: collection.topAnchor, constant: -space).isActive = true
        panel.widthAnchor.constraint(equalTo: panel.heightAnchor, multiplier: 1.65).isActive = true
    }

    private func setupStageConstraints() {
        stage.translatesAutoresizingMaskIntoConstraints = false
        stage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stage.topAnchor.constraint(equalTo: collection.bottomAnchor, constant: -5).isActive = true
        stage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        stage.heightAnchor.constraint(equalTo: stage.widthAnchor, multiplier: 0.275).isActive = true
    }

    private func setupChoiceConstraints() {
        choice.translatesAutoresizingMaskIntoConstraints = false
        choice.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        choice.topAnchor.constraint(equalTo: stage.bottomAnchor, constant: space / 2).isActive = true
        choice.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space / 2).isActive = true
        choice.widthAnchor.constraint(equalTo: choice.heightAnchor, multiplier: 2).isActive = true
    }

    private func setupResetConstraints() {
        reset.translatesAutoresizingMaskIntoConstraints = false
        reset.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        reset.centerYAnchor.constraint(equalTo: choice.centerYAnchor).isActive = true
        reset.heightAnchor.constraint(equalTo: choice.heightAnchor).isActive = true
        reset.widthAnchor.constraint(equalTo: reset.heightAnchor).isActive = true
    }

    // MARK: - UI State Updates

    /// UI update when waiting for player's initial door selection
    func waitingForFirstChoice() {
        reset.springAnimation { result in
            if result {
                self.reset.fadeOut(delay: 0.15)
            }
        }
        panel.tapToChooseADoor()
    }

    /// UI update when prompt for keep/switch choice appears
    func waitingForSecondChoice() {
        choice.fadeIn()
    }

    /// UI update after round completion revealing results
    func ended(_ secondChoice: SecondChoice) {
        switch secondChoice {
        case .keepDoor:
            choice.keepChoice.springAnimation { result in
                if result {
                    self.choice.fadeOut()
                    self.reset.fadeIn(delay: 0.5)
                }
            }
        case .switchDoor:
            choice.switchChoice.springAnimation { result in
                if result {
                    self.choice.fadeOut()
                    self.reset.fadeIn(delay: 0.5)
                }
            }
        }
    }
}

