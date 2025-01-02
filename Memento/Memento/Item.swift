//
//  Item.swift
//  Memento
//
//  Created by Matias Riveros-Amado on 11/25/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
