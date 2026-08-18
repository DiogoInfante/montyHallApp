//
//  ExperimentVC.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 01/11/21.
//

import UIKit

/// View controller allowing configuration and batch simulation of Monty Hall experiments
class ExperimentVC: BaseViewController<ExperimentView>, ExperimentDelegate {

    // MARK: - Properties

    let numberOfDoors: [Int] = [3, 4, 5, 6, 7, 8, 9, 10, 15, 20, 25, 50, 100, 250, 500, 1000]
    let secondChoices: [SecondChoice] = [.keepDoor, .switchDoor]
    let repetitions: [Int] = [1, 10, 100, 500, 1000, 10000]

    var selectedNumberOfDoors: Int = 3
    var selectedSecondChoice: SecondChoice = .keepDoor
    var selectedRepetitions: Int = 100

    // MARK: - Initialization

    init() {
        super.init(scene: ExperimentView())
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentView.update(.smoothBackground)

        set(delegate: self)
        view.addSubview(scene)
        scene.setScene(root: contentView)
        pickerDefaults()
    }

    // MARK: - SliderViewDelegate

    /// Executes the experiment simulation when the lever slider reaches completion
    func endCourse() {
        let experiment = Experiment(numberOfDoors: selectedNumberOfDoors,
                                     secondChoice: selectedSecondChoice,
                                     rounds: selectedRepetitions)
        experiment.run()
        scene.panel.displayExperiment(results: experiment.montyHall.results)
    }
}

// MARK: - UIPickerViewDataSource & UIPickerViewDelegate

extension ExperimentVC {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        for cell in scene.cells {
            switch cell.type {
            case .numberOfDoors:
                if pickerView == cell.uiPicker {
                    return numberOfDoors.count
                }
            case .secondChoice:
                if pickerView == cell.uiPicker {
                    return secondChoices.count
                }
            case .repetitions:
                if pickerView == cell.uiPicker {
                    return repetitions.count
                }
            }
        }
        return 0
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        for cell in scene.cells {
            switch cell.type {
            case .numberOfDoors:
                if pickerView == cell.uiPicker {
                    return String(numberOfDoors[row])
                }
            case .secondChoice:
                if pickerView == cell.uiPicker {
                    return secondChoices[row] == .keepDoor ? "Keep" : "Switch"
                }
            case .repetitions:
                if pickerView == cell.uiPicker {
                    return String(repetitions[row])
                }
            }
        }
        return ""
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        for cell in scene.cells {
            switch cell.type {
            case .numberOfDoors:
                if pickerView == cell.uiPicker {
                    selectedNumberOfDoors = numberOfDoors[row]
                    cell.textField.text = String(selectedNumberOfDoors)
                }
            case .secondChoice:
                if pickerView == cell.uiPicker {
                    selectedSecondChoice = secondChoices[row]
                    cell.textField.text = secondChoices[row] == .keepDoor ? "Keep" : "Switch"
                }
            case .repetitions:
                if pickerView == cell.uiPicker {
                    selectedRepetitions = repetitions[row]
                    cell.textField.text = String(repetitions[row])
                }
            }
        }
    }

    func pickerDefaults() {
        for cell in scene.cells {
            switch cell.type {
            case .numberOfDoors:
                if let defaultIndex = numberOfDoors.firstIndex(where: { $0 == selectedNumberOfDoors }) {
                    cell.uiPicker.selectRow(defaultIndex, inComponent: 0, animated: true)
                }
            case .secondChoice:
                if let defaultIndex = secondChoices.firstIndex(where: { $0 == selectedSecondChoice }) {
                    cell.uiPicker.selectRow(defaultIndex, inComponent: 0, animated: true)
                }
            case .repetitions:
                if let defaultIndex = repetitions.firstIndex(where: { $0 == selectedRepetitions }) {
                    cell.uiPicker.selectRow(defaultIndex, inComponent: 0, animated: true)
                }
            }
        }
    }
}

