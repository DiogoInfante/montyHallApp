//
//  HomeView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 31/10/21.
//

import UIKit

/// View containing main menu assets, title banner, and decorative artwork
class HomeView: NavigationView {

    // MARK: - Properties

    let banner = AssetView(.banner)
    let menu = MenuView()
    let goat = AssetView(.goat)
    let car = AssetView(.car)

    let space = UIScreen.main.bounds.height * 0.03

    // MARK: - Initialization

    init() {
        super.init(isRoot: true)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup & Layout

    func setupUI() {
        self.addSubview(menu)
        setupMenuConstraints()

        self.addSubview(banner)
        setupBannerConstraints()

        self.addSubview(car)
        setupCarConstraints()

        self.addSubview(goat)
        setupGoatConstraints()
        goat.rotate(angle: -12)

        self.bringSubviewToFront(menu)
    }

    private func setupMenuConstraints() {
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        menu.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        menu.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
        menu.widthAnchor.constraint(equalTo: menu.heightAnchor, multiplier: 1.47).isActive = true
    }

    private func setupBannerConstraints() {
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        banner.topAnchor.constraint(equalTo: self.topBar.bottomAnchor).isActive = true
        banner.bottomAnchor.constraint(equalTo: menu.topAnchor, constant: -space).isActive = true
        banner.widthAnchor.constraint(equalTo: banner.heightAnchor, multiplier: 1.33).isActive = true
    }

    private func setupCarConstraints() {
        car.translatesAutoresizingMaskIntoConstraints = false
        car.topAnchor.constraint(equalTo: menu.bottomAnchor, constant: space).isActive = true
        car.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space).isActive = true
        car.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 5 * space).isActive = true
        car.widthAnchor.constraint(equalTo: car.heightAnchor, multiplier: 1.82).isActive = true
    }

    private func setupGoatConstraints() {
        goat.translatesAutoresizingMaskIntoConstraints = false
        goat.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        goat.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space).isActive = true
        goat.leftAnchor.constraint(equalTo: self.leftAnchor, constant: -2 * space).isActive = true
        goat.widthAnchor.constraint(equalTo: goat.heightAnchor, multiplier: 0.82).isActive = true
    }
}

