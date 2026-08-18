//
//  TopBarView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 02/11/21.
//

import UIKit

/// Top bar header containing back navigation and soundtrack toggle controls
class TopBarView: UIView {

    // MARK: - Properties

    let pop = AssetView(.pop, subView: UIButton())
    let sound = AssetView(.discoOn, subView: UIButton())
    let space = UIScreen.main.bounds.width * 0.025

    // MARK: - Initialization

    init(root: Bool = false) {
        if root {
            pop.disappear()
        }
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup & Layout

    private func setupUI() {
        self.addSubview(pop)
        setupPopConstraints()

        self.addSubview(sound)
        setupSoundConstraints()
    }

    private func setupPopConstraints() {
        pop.translatesAutoresizingMaskIntoConstraints = false
        pop.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pop.leftAnchor.constraint(equalTo: self.leftAnchor, constant: space).isActive = true
        pop.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        pop.widthAnchor.constraint(equalTo: pop.heightAnchor, multiplier: 0.95).isActive = true
    }

    private func setupSoundConstraints() {
        sound.translatesAutoresizingMaskIntoConstraints = false
        sound.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        sound.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -space).isActive = true
        sound.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        sound.widthAnchor.constraint(equalTo: sound.heightAnchor, multiplier: 1.12).isActive = true
    }

    // MARK: - UI Updates

    /// Toggles the disco audio icon based on playback state
    func toggleDisco(_ isPlaying: Bool) {
        isPlaying ? sound.update(.discoOn) : sound.update(.discoOff)
    }
}

