

import Foundation


final class Store {
    var notifs: NotifSaver = load()
    // singleton
    static let shared = Store()
    static let changedNotification = Notification.Name("StoreChanged")
    
    func updating(index: Int, newLabel: String, newDate: Date, newDesc: String, timeRepeat: String) -> Void  {
        notifs[index].label = newLabel
        notifs[index].date = newDate
        notifs[index].description = newDesc
        notifs[index].timeRepeat = timeRepeat
    }
    
    func save(_ data: NotifSaver, notifying: Notif?, userInfo: [AnyHashable: Any]) {
        if let jsonData = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(jsonData, forKey: .UserDefaultsKey)
        }
        NotificationCenter.default.post(name: Store.changedNotification, object: notifying, userInfo: userInfo)
    }

    static func load() -> NotifSaver{
        if let data = UserDefaults.standard.data(forKey: .UserDefaultsKey) {
            if let alarms = try? JSONDecoder().decode(NotifSaver.self, from: data) {
                return alarms
            }
        }
        return NotifSaver()
    }
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: .UserDefaultsKey) // Clear specific key
        notifs = NotifSaver()
        NotificationCenter.default.post(name: Store.changedNotification, object: nil)
    }
    
    
    
}



fileprivate extension String {
    static let UserDefaultsKey = "UserDefaultsData"
}
