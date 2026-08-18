//
//  PickerView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 25/12/21.
//

import UIKit

/// Custom asset container housing a UIPickerView and corresponding icon symbol
class PickerView: AssetView<UIView> {

    // MARK: - Properties

    let uiPicker = UIPickerView()
    let textField = UITextField()
    var symbol = AssetView()
    let type: PickerType

    // MARK: - Initialization

    init(_ type: PickerType) {
        self.type = type
        super.init(.picker, subView: UIView())
        textField.inputView = uiPicker
        setupPicker()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup & Layout

    func setupUI() {
        self.addSubview(uiPicker)
        setupUIPickerConstraints()

        self.addSubview(symbol)
        setupSymbolConstraints()
    }

    private func setupPicker() {
        switch type {
        case .numberOfDoors:
            self.symbol = AssetView(.doorSymbol, subView: UIView())
        case .secondChoice:
            self.symbol = AssetView(.shuffleSymbol, subView: UIView())
        case .repetitions:
            self.symbol = AssetView(.repeatSymbol, subView: UIView())
        }
    }

    private func setupUIPickerConstraints() {
        uiPicker.translatesAutoresizingMaskIntoConstraints = false
        uiPicker.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        uiPicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        uiPicker.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.62).isActive = true
        uiPicker.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }

    private func setupSymbolConstraints() {
        symbol.translatesAutoresizingMaskIntoConstraints = false
        symbol.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        symbol.leftAnchor.constraint(equalTo: uiPicker.rightAnchor, constant: 10).isActive = true
        symbol.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        symbol.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.66).isActive = true
        symbol.contentMode = .scaleAspectFit
    }
}

