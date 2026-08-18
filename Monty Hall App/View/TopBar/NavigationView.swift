//
//  NavigationView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 02/11/21.
//

import UIKit

/// Base view container incorporating a top navigation bar
class NavigationView: UIView {

    // MARK: - Properties

    let isRoot: Bool
    lazy var topBar = TopBarView(root: isRoot)

    // MARK: - Initialization

    init(isRoot: Bool = false) {
        self.isRoot = isRoot
        super.init(frame: .zero)

        self.addSubview(topBar)
        setupTopBarConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout Constraints

    private func setupTopBarConstraints() {
        topBar.translatesAutoresizingMaskIntoConstraints = false
        topBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        topBar.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        topBar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    }
}

