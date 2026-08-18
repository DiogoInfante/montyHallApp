//
//  DoorCollectionView.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 17/02/21.
//

import UIKit

/// Custom `UICollectionView` using compositional layout to display interactive doors
class DoorCollectionView: UICollectionView {

    // MARK: - Initialization

    init() {
        super.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        self.frame = .zero
        self.backgroundColor = .clear
        self.collectionViewLayout = generateLayout()
        self.register(DoorCollectionViewCell.self, forCellWithReuseIdentifier: DoorCollectionViewCell.identifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Layout Generation

    /// Generates compositional layout for door grid (3 columns)
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let fullItem = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(2.0 / 3.0)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: fullItem,
            count: 3
        )

        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)

        self.isScrollEnabled = false
        return layout
    }
}

