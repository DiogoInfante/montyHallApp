//
//  UIViewExtensions.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 30/10/21.
//

import UIKit

// MARK: - General Layout Extensions

extension UIView {

    /// Calculates distance from center of view to a given point
    func centerTo(point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x - self.center.x, y: point.y - self.center.y)
    }

    /// Calculates distance from origin of view to a given point
    func originTo(point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x - self.frame.origin.x, y: point.y - self.frame.origin.y)
    }

    /// Rotates view by specified angle in degrees
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians)
        self.transform = rotation
    }
}

// MARK: - Constraints Extensions

extension UIView {

    /// Constrains subview to parent view with optional multiplier
    func constraint(to parent: UIView, multiplier: CGFloat = 1) {
        translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: parent.centerYAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: parent.widthAnchor, multiplier: multiplier).isActive = true
        self.heightAnchor.constraint(equalTo: parent.heightAnchor, multiplier: multiplier).isActive = true
    }

    /// Constrains view to layout margins of root view
    func setScene(root: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: root.layoutMarginsGuide.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: root.layoutMarginsGuide.bottomAnchor).isActive = true
        self.leadingAnchor.constraint(equalTo: root.layoutMarginsGuide.leadingAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: root.layoutMarginsGuide.trailingAnchor).isActive = true
    }
}

// MARK: - Animation Extensions

extension UIView {

    /// Applies rotation animation
    func rotate(duration: CFTimeInterval = 1,
                delay: CFTimeInterval = 0.0,
                fromValue: CGFloat = -0.5,
                toValue: CGFloat = 0.5,
                repeatCount: Float = 5,
                effect: AnimationOptions = .curveEaseIn,
                completion: @escaping ((Bool) -> Void) = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: effect,
                       animations: {
                        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
                        rotateAnimation.fromValue = fromValue
                        rotateAnimation.toValue = toValue
                        rotateAnimation.isRemovedOnCompletion = true
                        rotateAnimation.duration = duration
                        rotateAnimation.repeatCount = repeatCount
                        self.layer.add(rotateAnimation, forKey: nil)
                       }, completion: completion)
    }

    /// Fades view in to full opacity
    func fadeIn(duration: TimeInterval = 0.5,
                delay: TimeInterval = 0.0,
                effect: AnimationOptions = .curveEaseIn,
                completion: @escaping ((Bool) -> Void) = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: effect,
                       animations: {
                        self.alpha = 1.0
                       }, completion: completion)
    }

    /// Fades view out to zero opacity
    func fadeOut(duration: TimeInterval = 0.5,
                 delay: TimeInterval = 0.0,
                 effect: AnimationOptions = .curveEaseIn,
                 completion: @escaping ((Bool) -> Void) = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: effect,
                       animations: {
                        self.alpha = 0.0
                       }, completion: completion)
    }

    /// Fades view to custom target opacity
    func customFade(duration: TimeInterval = 0.5,
                    delay: TimeInterval = 0.0,
                    effect: AnimationOptions = .curveEaseIn,
                    toAlpha: CGFloat,
                    completion: @escaping ((Bool) -> Void) = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: effect,
                       animations: {
                        self.alpha = toAlpha
                       }, completion: completion)
    }

    /// Makes view appear quickly
    func appear(duration: TimeInterval = 0.01,
                delay: TimeInterval = 0.0,
                completion: @escaping ((Bool) -> Void) = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.alpha = 1.0
                       }, completion: completion)
    }

    /// Makes view disappear quickly
    func disappear(duration: TimeInterval = 0.01,
                   delay: TimeInterval = 0.0,
                   completion: @escaping (Bool) -> Void = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.alpha = 0.0
                       }, completion: completion)
    }

    /// Applies spring scaling animation
    func springAnimation(duration: TimeInterval = 0.2,
                          delay: TimeInterval = 0.0,
                          damping: CGFloat = 0.5,
                          initialVelocity: CGFloat = 0,
                          scale: CGFloat = 0.9,
                          effect: AnimationOptions = .curveEaseIn,
                          completion: @escaping ((Bool) -> Void) = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: initialVelocity,
                       options: effect, animations: {
                        self.transform = CGAffineTransform(scaleX: scale, y: scale)
                       }) { _ in
            UIView.animate(withDuration: duration,
                           delay: delay,
                           usingSpringWithDamping: damping,
                           initialSpringVelocity: initialVelocity,
                           options: effect, animations: {
                            self.transform = CGAffineTransform(scaleX: 1, y: 1)
                           }, completion: completion)
        }
    }

    /// Translates view center to target point
    func translation(duration: TimeInterval = 1,
                     delay: TimeInterval = 0.0,
                     centerTo: CGPoint,
                     completion: @escaping (Bool) -> Void = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        let distance = self.centerTo(point: centerTo)
                        self.transform = CGAffineTransform(translationX: distance.x, y: distance.y)
                       }, completion: completion)
    }

    /// Translates view origin to target point
    func translation(duration: TimeInterval = 1,
                     delay: TimeInterval = 0.0,
                     originTo: CGPoint,
                     completion: @escaping (Bool) -> Void = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        let distance = self.originTo(point: originTo)
                        self.transform = CGAffineTransform(translationX: distance.x, y: distance.y + self.frame.height)
                       }, completion: completion)
    }

    /// Translates view by coordinate deltas
    func translation(duration: TimeInterval = 1,
                     delay: TimeInterval = 0.0,
                     delta: CGPoint,
                     completion: @escaping (Bool) -> Void = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.transform = CGAffineTransform(translationX: delta.x, y: delta.y)
                       }, completion: completion)
    }

    /// Scales view by scaling factors
    func scaleBy(duration: TimeInterval = 1,
                 delay: TimeInterval = 0.0,
                 scaleX: CGFloat = 1,
                 scaleY: CGFloat = 1,
                 completion: @escaping (Bool) -> Void = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                       }, completion: completion)
    }

    /// Resets transform to identity
    func identity(duration: TimeInterval = 1,
                  delay: TimeInterval = 0.0,
                  completion: @escaping (Bool) -> Void = { (_: Bool) -> Void in }) {
        UIView.animate(withDuration: duration,
                       delay: delay,
                       options: UIView.AnimationOptions.curveEaseIn,
                       animations: {
                        self.transform = CGAffineTransform.identity
                       }, completion: completion)
    }
}
