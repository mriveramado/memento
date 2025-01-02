
import Foundation

class Notif: Codable {
    let uuid: UUID
    var date: Date
    @Published var enabled: Bool {willSet {
        print("willSet: enabled will change from \(enabled) to \(newValue)")
    }
        didSet {
            print("didSet: enabled changed from \(oldValue) to \(enabled)")
        }}
    
    var descEnabled: Bool
    var repeatWeekdays: [Int]
    var mediaID: String
    var mediaLabel: String
    @Published var label: String
    @Published var description: String
    @Published var timeRepeat: String
    
    
    
    
    convenience init() {
        self.init(uuid: UUID(), date: Date(), enabled: true, descEnabled: false, repeatWeekdays: [], mediaID: "", mediaLabel: "bell", label: "Alarm", description: " ", timeRepeat: "")
    }
    
    init(uuid: UUID, date: Date, enabled: Bool, descEnabled: Bool, repeatWeekdays: [Int], mediaID: String, mediaLabel: String, label: String, description: String, timeRepeat: String) {
        self.uuid = uuid
        self.date = date
        self.enabled = enabled
        self.descEnabled = descEnabled
        self.repeatWeekdays = repeatWeekdays
        self.mediaID = mediaID
        self.mediaLabel = mediaLabel
        self.label = label
        self.description = description
        self.timeRepeat = timeRepeat
    }
    
    enum CodingKeys: CodingKey {
        case uuid
        case date
        case enabled
        case snoozeEnabled
        case repeatWeekdays
        case mediaID
        case mediaLabel
        case label
        case description
        case timeRepeat
    }
    
    required init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Notif.CodingKeys> = try decoder.container(keyedBy: Notif.CodingKeys.self)
        
        self.uuid = try container.decode(UUID.self, forKey: Notif.CodingKeys.uuid)
        self.date = try container.decode(Date.self, forKey: Notif.CodingKeys.date)
        self.enabled = try container.decode(Bool.self, forKey: Notif.CodingKeys.enabled)
        self.descEnabled = try container.decode(Bool.self, forKey: Notif.CodingKeys.snoozeEnabled)
        self.repeatWeekdays = try container.decode([Int].self, forKey: Notif.CodingKeys.repeatWeekdays)
        self.mediaID = try container.decode(String.self, forKey: Notif.CodingKeys.mediaID)
        self.mediaLabel = try container.decode(String.self, forKey: Notif.CodingKeys.mediaLabel)
        self.label = try container.decode(String.self, forKey: Notif.CodingKeys.label)
        self.description = try container.decode(String.self, forKey: Notif.CodingKeys.description)
        self.timeRepeat = try container.decode(String.self, forKey: Notif.CodingKeys.timeRepeat)
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<Notif.CodingKeys> = encoder.container(keyedBy: Notif.CodingKeys.self)
        
        try container.encode(self.uuid, forKey: Notif.CodingKeys.uuid)
        try container.encode(self.date, forKey: Notif.CodingKeys.date)
        try container.encode(self.enabled, forKey: Notif.CodingKeys.enabled)
        try container.encode(self.descEnabled, forKey: Notif.CodingKeys.snoozeEnabled)
        try container.encode(self.repeatWeekdays, forKey: Notif.CodingKeys.repeatWeekdays)
        try container.encode(self.mediaID, forKey: Notif.CodingKeys.mediaID)
        try container.encode(self.mediaLabel, forKey: Notif.CodingKeys.mediaLabel)
        try container.encode(self.label, forKey: Notif.CodingKeys.label)
        try container.encode(self.description, forKey: Notif.CodingKeys.description)
        try container.encode(self.timeRepeat, forKey: Notif.CodingKeys.timeRepeat)

    }
}

extension Notif {
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self.date)
    }
}

extension Notif {
    static let changeReasonKey = "reason"
    static let newValueKey = "newValue"
    static let oldValueKey = "oldValue"
    static let updated = "updated"
    static let added = "added"
    static let removed = "removed"
}

