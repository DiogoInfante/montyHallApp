//
//  PuzzleVC.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 16/02/21.
//

import UIKit

/// View controller managing interactive 3-door Monty Hall gameplay
class PuzzleVC: BaseViewController<PuzzleView>, PuzzleDelegate {

    // MARK: - Properties

    var stateMachine = StateMachine()
    var montyHallProblem = MontyHallProblem(3)

    // MARK: - Initialization

    init() {
        super.init(scene: PuzzleView())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.update(.smoothBackground)

        view.addSubview(scene)
        scene.setScene(root: contentView)
        set(delegate: self)

        scene.choice.switchChoice.subView.addTarget(self, action: #selector(switchChoice), for: .touchUpInside)
        scene.choice.keepChoice.subView.addTarget(self, action: #selector(keepChoice), for: .touchUpInside)
        scene.reset.subView.addTarget(self, action: #selector(reset), for: .touchUpInside)

        stateMachine.start()
    }

    // MARK: - Game Actions

    @objc func keepChoice() {
        if stateMachine.currentState == .waitingForSecondChoice {
            stateMachine.madeSecondChoice(.keepDoor)
        }
    }

    @objc func switchChoice() {
        if stateMachine.currentState == .waitingForSecondChoice {
            stateMachine.madeSecondChoice(.switchDoor)
        }
    }

    @objc func reset() {
        if stateMachine.currentState == .ended {
            stateMachine.reset()
        }
    }
}

// MARK: - UICollectionViewDelegate & UICollectionViewDataSource

extension PuzzleVC {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return montyHallProblem.numberOfDoors
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DoorCollectionViewCell.identifier,
            for: indexPath) as? DoorCollectionViewCell else { return DoorCollectionViewCell() }

        cell.door = montyHallProblem.doors[indexPath.item]
        cell.door.observer = cell
        cell.setDoorNumber(indexPath.item + 1)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if stateMachine.currentState == .waitingForFirstChoice {
            stateMachine.madeFirstChoice(indexPath.item)
        }
    }
}

// MARK: - StateObserver Conformance

extension PuzzleVC {

    func changingStateFor(event: GameEvent, from oldState: GameState, to newState: GameState) {
        switch (event, newState) {
        case (.start, .waitingForFirstChoice):
            break

        case (.madeFirstChoice(let id), .waitingForSecondChoice):
            montyHallProblem.firstChoice(id)
            scene.panel.askForSecondChoice(openIds: montyHallProblem.getOpenIds(),
                                           chosenId: montyHallProblem.getChoosenId(),
                                           switchId: montyHallProblem.getSwitchId())
            scene.waitingForSecondChoice()

        case (.madeSecondChoice(let choice), .ended):
            let didWin = montyHallProblem.secondChoice(choice)
            scene.panel.displayResults(didWin: didWin, results: montyHallProblem.results)
            montyHallProblem.openAll()
            scene.ended(choice)

        case (.reset, .waitingForFirstChoice):
            montyHallProblem.reset()
            scene.waitingForFirstChoice()

        default:
            break
        }
    }
}

