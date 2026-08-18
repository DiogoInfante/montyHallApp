//
//  HomeVC.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 31/10/21.
//

import UIKit

/// Root view controller presenting the main menu navigation
class HomeVC: BaseViewController<HomeView> {

    // MARK: - Properties

    typealias Factory = PuzzleVCFactory & ExperimentVCFactory & TutorialVCFactory
    let factory: Factory

    var selectionId: Int = 0

    // MARK: - Initialization

    init(factory: Factory) {
        self.factory = factory
        super.init(scene: HomeView())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.update(.background)
        view.addSubview(scene)
        setupSceneConstraints()

        scene.menu.button.subView.addTarget(self, action: #selector(tappedNavigation), for: .touchUpInside)
        scene.menu.nextArrow.subView.addTarget(self, action: #selector(tappedNext), for: .touchUpInside)
        scene.menu.backArrow.subView.addTarget(self, action: #selector(tappedPrevious), for: .touchUpInside)
    }

    // MARK: - Navigation Actions

    @objc func tappedNavigation() {
        if selectionId == 0 {
            let puzzleVC = factory.makePuzzleVC()
            self.navigationController?.pushViewController(puzzleVC, animated: true)
        } else if selectionId == 1 {
            let experimentVC = factory.makeExperimentVC()
            self.navigationController?.pushViewController(experimentVC, animated: true)
        } else {
            displayAlert(message: "Problem Explanation")
        }
    }

    @objc func tappedNext() {
        if selectionId < 2 {
            selectionId += 1
            scene.menu.didSelect(selectionId)
        }
    }

    @objc func tappedPrevious() {
        if selectionId > 0 {
            selectionId -= 1
            scene.menu.didSelect(selectionId)
        }
    }

    // MARK: - Helper Methods

    func displayAlert(message: String) {
        let alert = UIAlertController(title: "Coming Soon", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    // MARK: - Layout Constraints

    private func setupSceneConstraints() {
        scene.translatesAutoresizingMaskIntoConstraints = false
        scene.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        scene.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        scene.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scene.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}

