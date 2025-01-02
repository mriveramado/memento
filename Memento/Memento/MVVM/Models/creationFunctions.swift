//  Created by Matias Riveros-Amado on 12/26/24.

import SwiftUI
import Foundation

//

func initialNotifCreations(date: Date, isEnabled: Bool, allowDesc: Bool, selectedWeekdays: Set<Int>, label: String, description: String) -> Void {
//variable introduction
    
    
    let newAlarm = Notif(uuid: UUID(), date: date, enabled: isEnabled, descEnabled: allowDesc, repeatWeekdays: Array(selectedWeekdays).sorted(), mediaID: "", mediaLabel: "bell", label: label, description: description, timeRepeat: "")
    let content = UNMutableNotificationContent()
    content.title = newAlarm.label
    content.body = newAlarm.description
    content.sound = UNNotificationSound.default
    content.categoryIdentifier = "notifAction"
    let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: newAlarm.date)
    let trigger2 = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
    let request2 = UNNotificationRequest(identifier: newAlarm.uuid.uuidString, content: content, trigger: trigger2)
    
// interaction logic
    let completed = UNNotificationAction(identifier: "complete", title: "I have completed this.")
    let category = UNNotificationCategory(identifier: "notifAction", actions: [completed], intentIdentifiers: [])
    UNUserNotificationCenter.current().setNotificationCategories([category])
    print("send")
//setting
    UNUserNotificationCenter.current().add(request2) { error in
        if let error = error {
            print("Error scheduling notification: \(error)")
        }
    }
    
    
}

//PERSISTENT

func notifCreationsWithDelay(ids: String, date: Date, timeRepeatDays: String, timeRepeatHours: String, timeRepeatMins: String, isEnabled: Bool, allowDesc: Bool, selectedWeekdays: Set<Int>, label: String, description: String) -> Void {
    
    
    @State var elapsed = abs(Date.now.timeIntervalSince(date))
    @State var delay: Timer?
    print(elapsed)
    
    delay = Timer.scheduledTimer(withTimeInterval: elapsed, repeats: false) { _ in
        
//variable introductions
        @State var totaltime: String = "Repeats every " + timeRepeatDays + " days, " + timeRepeatHours + " hours, " + timeRepeatMins + " minutes."
        
        let newAlarm = Notif(uuid: UUID(), date: date, enabled: isEnabled, descEnabled: allowDesc, repeatWeekdays: Array(selectedWeekdays).sorted(), mediaID: "", mediaLabel: "bell", label: label, description: description, timeRepeat: totaltime)
        
        let content = UNMutableNotificationContent()
        content.title = newAlarm.label
        content.body = newAlarm.description
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "notifAction"
        
        let minsToSec = (Int(timeRepeatMins) ?? 0) * 60
        let hrsToSec = (Int(timeRepeatHours) ?? 0) * 3600
        let dysToSec = (Int(timeRepeatDays) ?? 0) * 3600 * 24
        let totSec = minsToSec + hrsToSec + dysToSec
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(totSec), repeats: true)
// interaction logic
        let completed = UNNotificationAction(identifier: "complete", title: "I have completed this.")
        let category = UNNotificationCategory(identifier: "notifAction", actions: [completed], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        print("persistent notification has been created")
        
//notification set
        let request = UNNotificationRequest(identifier: ids, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
    
}
/// This part after is for the Insights feature. It is very strange because I used the base that I had for the notification persistent data model, but when I implement it, not only does it not work, it makes the notification store not work either.
/*
func interactionLog(label: String, timeRepeatDays: Double, timeRepeatHours: Double, timeRepeatMins: Double, date: Date, id: String) -> Void{
    @State var timer: Timer?
    @StateObject var notifs = Store.shared.notifs

    @State var interval: Double = (timeRepeatDays * 3600 * 24) + (timeRepeatHours * 3600 ) + (timeRepeatMins * 60)
    @StateObject var interactions = interactionStore.shared.interactions
    let test = interaction(label: label, completed: true, id: "gey")
    print(":bropo")
    
    timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
        print("hpiioj")
        if notifs.containsID(id) && notifs.containsLabel(label){
            interactions.add(test)
            interactionStore.shared.interactions.refresh()
            print("yepers")
        }else{
            if let timer {
                timer.invalidate()
                print("bye bye")
            } else {
                print("something has gone horrifically wrong")
            }
            
        }
    }
}
*/

