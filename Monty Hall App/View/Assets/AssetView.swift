//
//  AssetView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 30/10/21.
//

import UIKit

/// Custom `UIImageView` containing a generic subview overlaid with specified scaling constraints
class AssetView<T: UIView>: UIImageView {

    // MARK: - Properties

    var subView: T
    var scale: CGFloat

    // MARK: - Initialization

    /// Initializes an asset view with an asset image and embedded subview
    /// - Parameters:
    ///   - asset: Asset image case used as background
    ///   - subView: Embedded subview instance
    ///   - scale: Scale factor relative to container
    init(_ asset: Asset = .empty, subView: T = T(), _ scale: CGFloat = 1) {
        self.subView = subView
        self.scale = scale
        super.init(image: Asset.get(asset))
        self.isUserInteractionEnabled = true
        setup(subView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup & Configuration

    /// Configures layout and constraints for embedded subview
    func setup(_ subView: T) {
        self.addSubview(subView)
        subView.constraint(to: self, multiplier: self.scale)
    }

    /// Updates background image using a new asset
    func update(_ newAsset: Asset) {
        self.image = Asset.get(newAsset)
    }
}

