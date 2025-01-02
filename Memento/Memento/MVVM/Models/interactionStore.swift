//  Created by Matias Riveros-Amado on 12/28/24.


import SwiftUI

/// This is built from the "store,swift" file. Everything is the same. It is very strange because I used the base that I had for the notification persistent data model, but when I implement it, not only does it not work, it makes the notification store not work either.


/*
final class interactionStore {
    var interactions: InteractionSaver = load()
    // singleton
    static let shared = interactionStore()
    static let changedInteraction = Notification.Name("StoreChanged")
   
    
    
    func save(_ data: InteractionSaver, notifying: interaction?, userInfo: [AnyHashable: Any]) {
        if let jsonData = try? JSONEncoder().encode(data) {
            UserDefaults.standard.set(jsonData, forKey: .UserDefaultsKey)
        }
        NotificationCenter.default.post(name: interactionStore.changedInteraction, object: notifying, userInfo: userInfo)
    }

    static func load() -> InteractionSaver{
        if let data = UserDefaults.standard.data(forKey: .UserDefaultsKey) {
            if let interactions = try? JSONDecoder().decode(InteractionSaver.self, from: data) {
                return interactions
            }
        }
        return InteractionSaver()
    }
    
    
}



fileprivate extension String {
    static let UserDefaultsKey = "UserDefaultsData"
}
*/
