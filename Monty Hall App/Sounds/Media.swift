//
//  Media.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 02/11/21.
//

import Foundation

/// Media resource model identified by filename title and file extension type
struct Media {
    let title: String
    let type: String

    init(title: String, type: String) {
        self.title = title
        self.type = type
    }
}

