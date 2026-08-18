//
//  IntExtensions.swift
//  Monty Hall App
//
//  Created by Diogo Infante on 01/11/21.
//

import Foundation

/// Extensions on integer arrays for formatted output
extension Array where Element == Int {

    /// Returns a new array with a constant added to each element
    func increment(_ constant: Int) -> [Int] {
        return self.map { $0 + constant }
    }

    /// Returns a joined string of all elements separated by the given delimiter
    func getString(separator: String = ",") -> String {
        return self.map(String.init).joined(separator: separator)
    }
}

