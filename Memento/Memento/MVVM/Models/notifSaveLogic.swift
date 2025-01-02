

import Foundation

class NotifSaver: ObservableObject, Codable {
    @Published  var notifs: [Notif]

    func remove(at index: Int) {
            guard index >= 0 && index < notifs.count else { return }
            notifs.remove(at: index)
            Store.shared.save(self, notifying: nil, userInfo: [:])
        }
    
    func refresh() {
            Store.shared.save(self, notifying: nil, userInfo: [:])
        }
    
    enum CodingKeys: CodingKey {
        case notifs
    }

    init() {
        self.notifs = [Notif]()
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.notifs = try container.decode([Notif].self, forKey: .notifs)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.notifs, forKey: .notifs)
    }

    func add(_ alarm: Notif) {
        notifs.append(alarm)
    }

    func containsID(_ id: String) -> Bool {
        return notifs.filter{$0.uuid.uuidString == id}.count > 0
    }
    func containsLabel(_ label: String) -> Bool {
        return notifs.filter{$0.label == label}.count > 0
    }
    
    var count: Int {
        return notifs.count
    }

    subscript(index: Int) -> Notif {
        get {
                    return notifs[index]
                }
                set {
                    notifs[index] = newValue
                }
    }
}
