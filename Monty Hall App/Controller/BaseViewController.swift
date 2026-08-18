//
//  BaseViewController.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 30/10/21.
//

import UIKit

/// Base view controller providing layout container and top bar actions
class BaseViewController<T: NavigationView>: UIViewController {

    // MARK: - Properties

    var scene: T
    var contentView: AssetView<UIView>

    // MARK: - Initialization

    init(asset: Asset = .background, scene: T) {
        self.contentView = AssetView()
        self.scene = scene
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mPallete1
        self.navigationController?.navigationBar.isHidden = true

        view.addSubview(contentView)
        contentView.constraint(to: self.view)

        scene.topBar.sound.subView.addTarget(self, action: #selector(toggleMusic), for: .touchUpInside)
        scene.topBar.pop.subView.addTarget(self, action: #selector(pop), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scene.topBar.toggleDisco(audioManager.player.isPlaying)
    }

    // MARK: - Actions

    @objc func toggleMusic() {
        audioManager.toggleMusic()
        scene.topBar.toggleDisco(audioManager.player.isPlaying)
    }

    @objc func pop() {
        self.navigationController?.popViewController(animated: true)
    }
}

