//
//  ExperimentView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 01/11/21.
//

import UIKit

/// View laying out parameter selection pickers and the execution trigger lever
class ExperimentView: NavigationView {

    // MARK: - Properties

    let panel = PanelView()
    let pickerStack = AssetView(.experimentBoard, subView: UIStackView(), 0.7)
    let cells = [PickerView(.numberOfDoors),
                 PickerView(.secondChoice),
                 PickerView(.repetitions)]
    let lever = SliderView(bar: .rail, pointer: .lever)

    let space = UIScreen.main.bounds.height * 0.03

    // MARK: - Initialization

    init() {
        super.init()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup & Layout

    func setupUI() {
        self.addSubview(panel)
        setupPanelConstraints()
        panel.requestExperiment()

        self.addSubview(lever)
        setupLeverConstraints()

        self.addSubview(pickerStack)
        setupPickerStackConstraints()
        setupStack()
        setupCellsConstraints()
    }

    private func setupPanelConstraints() {
        panel.translatesAutoresizingMaskIntoConstraints = false
        panel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        panel.topAnchor.constraint(equalTo: self.topBar.bottomAnchor).isActive = true
        panel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        panel.heightAnchor.constraint(equalTo: panel.widthAnchor, multiplier: 0.6).isActive = true
    }

    private func setupLeverConstraints() {
        lever.translatesAutoresizingMaskIntoConstraints = false
        lever.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        lever.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -space / 2).isActive = true
        lever.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        lever.heightAnchor.constraint(equalTo: panel.widthAnchor, multiplier: 0.2).isActive = true
    }

    private func setupPickerStackConstraints() {
        pickerStack.translatesAutoresizingMaskIntoConstraints = false
        pickerStack.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        pickerStack.topAnchor.constraint(equalTo: panel.bottomAnchor, constant: space).isActive = true
        pickerStack.bottomAnchor.constraint(equalTo: lever.topAnchor, constant: -space).isActive = true
        pickerStack.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.83).isActive = true
    }

    private func setupStack() {
        pickerStack.subView.isUserInteractionEnabled = true
        pickerStack.subView.alignment = .center
        pickerStack.subView.distribution = .equalSpacing
        pickerStack.subView.axis = .vertical
    }

    private func setupCellsConstraints() {
        for cell in cells {
            pickerStack.subView.addArrangedSubview(cell)
            cell.translatesAutoresizingMaskIntoConstraints = false
            cell.heightAnchor.constraint(equalTo: pickerStack.subView.heightAnchor, multiplier: 0.25).isActive = true
            cell.widthAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 2.7).isActive = true
        }
    }
}

