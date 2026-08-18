//
//  TutorialVC.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 01/11/21.
//

import UIKit

/// View controller presenting the explanation of the Monty Hall problem
class TutorialVC: BaseViewController<NavigationView> {

    // MARK: - Initialization

    init() {
        super.init(scene: TutorialView())
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
    }
}

