//  Created by Matias Riveros-Amado on 12/28/24.


///This is akin to the "notif.swift" file.  It is very strange because I used the base that I had for the notification persistent data model, but when I implement it, not only does it not work, it makes the notification store not work either.

/*
import Foundation
import SwiftUI
import Charts

extension Date {
    static func random(in range: ClosedRange<Date>) -> Date {
        let diff = range.upperBound.timeIntervalSinceReferenceDate - range.lowerBound.timeIntervalSinceReferenceDate
        let randomValue = diff * Double.random(in: 0...1) + range.lowerBound.timeIntervalSinceReferenceDate
        return Date(timeIntervalSinceReferenceDate: randomValue)
    }
}


class interaction: Codable {
    @Published var date: Date
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self.date)
    }
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: self.date)
    }
    @Published var label: String
    @Published var completed: Bool
    /*
     var totNotifs: Int
     var compNotifs: Int
     var uncompNotifs: Int{
     guard totNotifs - compNotifs > 0 else{return 0}
     return totNotifs - compNotifs}
     var compPercent: Double{
     guard totNotifs > 0 else {return 0}
     return Double(compNotifs/totNotifs) * 100
     }
     */
    @Published var id: String
    
    convenience init() {
        self.init(date: Date(), label: "Notif", completed: false, id: "")
    }
    
    init(date: Date, label: String, completed: Bool, id: String) {
        self.date = date
        self.label = label
        self.completed = completed
        self.id = id
    }
    
    enum CodingKeys: CodingKey {
        case date
        case label
        case completed
        case id
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<interaction.CodingKeys> = try decoder.container(keyedBy: interaction.CodingKeys.self)
        
        self.date = try container.decode(Date.self, forKey: interaction.CodingKeys.date)
        self.label = try container.decode(String.self, forKey: interaction.CodingKeys.label)
        self.completed = try container.decode(Bool.self, forKey: interaction.CodingKeys.completed)
        self.id = try container.decode(String.self, forKey: interaction.CodingKeys.id)

        
    }
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<interaction.CodingKeys> = encoder.container(keyedBy: interaction.CodingKeys.self)
        
        try container.encode(self.date, forKey: interaction.CodingKeys.date)
        try container.encode(self.label, forKey: interaction.CodingKeys.label)
        try container.encode(self.completed, forKey: interaction.CodingKeys.completed)
        try container.encode(self.id, forKey: interaction.CodingKeys.id)

        
        
    }
}


extension interaction {
    static let changeReasonKey = "reason"
    static let newValueKey = "newValue"
    static let oldValueKey = "oldValue"
    static let updated = "updated"
    static let added = "added"
    static let removed = "removed"
}
*/
