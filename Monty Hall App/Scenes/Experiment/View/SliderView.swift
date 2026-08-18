//
//  SliderView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 26/12/21.
//

import UIKit

// MARK: - SliderViewDelegate

/// Delegate notified when the slider reaches the end of its course
protocol SliderViewDelegate: AnyObject {
    func endCourse()
}

// MARK: - SliderView

/// Interactive slider lever control triggering experiment execution
class SliderView: UIView {

    // MARK: - Properties

    let bar: AssetView<UIView>
    let pointer: AssetView<UIView>
    weak var delegate: SliderViewDelegate?

    private var pointerLeftConstraint: NSLayoutConstraint?

    // MARK: - Initialization

    init(bar: Asset, pointer: Asset) {
        self.bar = AssetView(bar, subView: UIView())
        self.pointer = AssetView(pointer, subView: UIView())
        super.init(frame: .zero)
        setupGestures()
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup & Layout

    func setupUI() {
        self.addSubview(bar)
        setupBarConstraints()

        self.addSubview(pointer)
        setupPointerConstraints()
    }

    private func setupBarConstraints() {
        bar.translatesAutoresizingMaskIntoConstraints = false
        bar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        bar.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        bar.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        bar.heightAnchor.constraint(equalTo: bar.widthAnchor, multiplier: 0.095).isActive = true
    }

    private func setupPointerConstraints() {
        pointer.translatesAutoresizingMaskIntoConstraints = false

        pointerLeftConstraint = pointer.centerXAnchor.constraint(equalTo: bar.leftAnchor)
        pointerLeftConstraint?.isActive = true

        pointer.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        pointer.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.8).isActive = true
        pointer.widthAnchor.constraint(equalTo: pointer.heightAnchor).isActive = true
    }

    private func setupGestures() {
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        pointer.addGestureRecognizer(gestureRecognizer)
        pointer.isUserInteractionEnabled = true
    }

    // MARK: - Gesture Handling & Animation

    @objc private func handlePan(_ sender: UIPanGestureRecognizer) {
        let barWidth = bar.frame.width
        let location = sender.location(in: bar)

        let clampedX = max(0, min(location.x, barWidth))
        pointerLeftConstraint?.constant = clampedX

        if sender.state == .ended {
            let progress = clampedX / barWidth

            if progress >= 0.98 {
                delegate?.endCourse()
                animateBack(duration: 0.5, delay: 1.0)
            } else {
                animateBack(duration: 0.2, delay: 0.0)
            }
        }
    }

    func animateBack(duration: CGFloat, delay: CGFloat) {
        pointer.isUserInteractionEnabled = false
        pointerLeftConstraint?.constant = 0

        UIView.animate(withDuration: TimeInterval(duration),
                       delay: TimeInterval(delay),
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            self.layoutIfNeeded()
        }) { _ in
            self.pointer.isUserInteractionEnabled = true
        }
    }
}

