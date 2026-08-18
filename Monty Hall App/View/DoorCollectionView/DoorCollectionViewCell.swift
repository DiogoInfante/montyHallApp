//
//  DoorCollectionViewCell.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 15/02/21.
//

import UIKit

/// Collection view cell representing a single door and its revealed content
class DoorCollectionViewCell: UICollectionViewCell, ObserverProtocol {

    // MARK: - Properties

    static let identifier = "DoorCollectionViewCell"

    var door: Door = Door(-1) {
        didSet {
            if door.isPrized {
                prizeDoorSetup()
            } else {
                goatDoorSetup()
            }
        }
    }

    let doorView = AssetView(.door)
    let behindView = AssetView(.goatDoor)
    let label = UILabel()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(behindView)
        setupBehindViewConstraints()

        contentView.addSubview(doorView)
        setupDoorViewConstraints()

        contentView.addSubview(label)
        setupLabelConstraints()

        label.font = UIFont(name: "PhosphateRRSolid", size: 35)
        label.textColor = .mIce
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - ObserverProtocol

    func stateUpdated(_ newState: DoorState) {
        switch newState {
        case .opened:
            openDoor()
        case .closed:
            closeDoor()
        }
    }

    func prizeUpdated(_ isPrized: Bool) {
        isPrized ? prizeDoorSetup() : goatDoorSetup()
    }

    // MARK: - Configuration

    /// Sets the door number displayed on the cell label
    func setDoorNumber(_ doorNumber: Int) {
        label.text = String(doorNumber)
        label.textAlignment = .center
    }

    // MARK: - Layout Constraints

    private func setupBehindViewConstraints() {
        behindView.translatesAutoresizingMaskIntoConstraints = false
        behindView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        behindView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        behindView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        behindView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }

    private func setupDoorViewConstraints() {
        doorView.translatesAutoresizingMaskIntoConstraints = false
        doorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        doorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        doorView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        doorView.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }

    private func setupLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: contentView.heightAnchor).isActive = true
    }

    // MARK: - Visual State Changes

    private func prizeDoorSetup() {
        behindView.update(.carDoor)
    }

    private func goatDoorSetup() {
        behindView.update(.goatDoor)
    }

    private func openDoor() {
        doorView.alpha = 0
        label.alpha = 0
    }

    private func closeDoor() {
        doorView.alpha = 1
        label.alpha = 1
    }
}

