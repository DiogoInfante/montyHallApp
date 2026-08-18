//
//  ChoiceView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 30/10/21.
//

import UIKit

/// Container view holding the "Keep" and "Switch" choice buttons
class ChoiceView: UIView {

    // MARK: - Properties

    let keepChoice = AssetView(.choice, subView: UIButton())
    let switchChoice = AssetView(.choice, subView: UIButton())

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
        self.addSubview(keepChoice)
        setupKeepChoiceConstraints()
        keepChoice.subView.setTitle("Keep", for: .normal)
        keepChoice.subView.setTitleColor(.mGray, for: .normal)
        keepChoice.subView.titleLabel?.font = UIFont(name: "PhosphateRRSolid", size: 25)
        keepChoice.subView.titleLabel?.textAlignment = .center

        self.addSubview(switchChoice)
        setupSwitchChoiceConstraints()
        switchChoice.subView.setTitle("Switch", for: .normal)
        switchChoice.subView.setTitleColor(.mGray, for: .normal)
        switchChoice.subView.titleLabel?.font = UIFont(name: "PhosphateRRSolid", size: 25)
        switchChoice.subView.titleLabel?.textAlignment = .center
    }

    private func setupKeepChoiceConstraints() {
        keepChoice.translatesAutoresizingMaskIntoConstraints = false
        keepChoice.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        keepChoice.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        keepChoice.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
        keepChoice.heightAnchor.constraint(equalTo: keepChoice.widthAnchor).isActive = true
    }

    private func setupSwitchChoiceConstraints() {
        switchChoice.translatesAutoresizingMaskIntoConstraints = false
        switchChoice.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        switchChoice.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        switchChoice.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
        switchChoice.heightAnchor.constraint(equalTo: switchChoice.widthAnchor).isActive = true
    }
}

