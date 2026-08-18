//
//  ExperimentDelegate.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 25/12/21.
//

import UIKit

/// Composite protocol grouping pickers, text field, and slider delegates for ExperimentVC
protocol ExperimentDelegate: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, SliderViewDelegate {
    var scene: ExperimentView { get set }
    func set(delegate: ExperimentDelegate)
}

extension ExperimentDelegate {
    func set(delegate: ExperimentDelegate) {
        for cell in scene.cells {
            cell.uiPicker.delegate = self
            cell.uiPicker.dataSource = self
            cell.textField.delegate = self
        }
        scene.lever.delegate = self
    }
}

