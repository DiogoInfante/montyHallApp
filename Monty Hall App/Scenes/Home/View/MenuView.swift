//
//  MenuView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 01/11/21.
//

import UIKit

/// Interactive menu carousel for mode selection (Puzzle, Experiment, Book)
class MenuView: UIView {

    // MARK: - Properties

    let button = AssetView(.play, subView: UIButton())
    let nextArrow = AssetView(.next, subView: UIButton())
    let backArrow = AssetView(.back, subView: UIButton())

    let space = UIScreen.main.bounds.width * 0.05

    // MARK: - Initialization

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup & Layout

    private func setupUI() {
        self.addSubview(button)
        setupButtonConstraints()

        self.addSubview(backArrow)
        setupBackArrowConstraints()

        self.addSubview(nextArrow)
        setupNextArrowConstraints()
    }

    private func setupButtonConstraints() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.625).isActive = true
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
    }

    private func setupBackArrowConstraints() {
        backArrow.translatesAutoresizingMaskIntoConstraints = false
        backArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        backArrow.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        backArrow.rightAnchor.constraint(equalTo: button.leftAnchor).isActive = true
        backArrow.heightAnchor.constraint(equalTo: backArrow.widthAnchor).isActive = true
    }

    private func setupNextArrowConstraints() {
        nextArrow.translatesAutoresizingMaskIntoConstraints = false
        nextArrow.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        nextArrow.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        nextArrow.leftAnchor.constraint(equalTo: button.rightAnchor).isActive = true
        nextArrow.heightAnchor.constraint(equalTo: nextArrow.widthAnchor).isActive = true
    }

    // MARK: - Selection Updates

    /// Updates menu appearance based on currently selected index
    /// - Parameter id: Index of selected menu option (0: Puzzle, 1: Experiment, 2: Book)
    func didSelect(_ id: Int) {
        if id == 0 {
            button.update(.play)
            backArrow.disappear()
        } else if id == 1 {
            button.update(.experiment)
            backArrow.appear()
            nextArrow.appear()
        } else {
            button.update(.book)
            nextArrow.disappear()
        }
    }
}

