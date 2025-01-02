//  Created by Matias Riveros-Amado on 11/29/24.
//


import SwiftUI

struct editingNotif: View {
    @StateObject private var notifs = Store.shared.notifs
    @State var editing: Bool = false
    @State private var showingAlert = false
    @State var ind: Int = 2

    var padding: CGFloat? = -10
    @State var showSheet: Bool = false
    
    var body: some View {
        ScrollView{
            ForEach(0..<notifs.count, id: \.self) { index in
                
    
        
                        
                    HStack{
                        
                        NavigationLink(destination: notifDetails(notif: Binding(
                            get: { notifs[index] },
                            set: { notifs[index] = $0 }
                        ))){
                            dumbEdit(label: notifs[index].label, setFor: notifs[index].formattedTime, repetition: "\(notifs[index].timeRepeat)").padding(.bottom, padding)
                        }
                        VStack{
                                NavigationLink {
                                    updateNotif(index: index, label: notifs[index].label, description: notifs[index].description, showSheet: $showSheet, isEnabled: notifs[index].enabled, selectedWeekdays: [1, 2], allowDesc: notifs[index].descEnabled)
                                    
                                    
                                } label: {
                                    stupidEdit()
                                    
                                }
                            Button{
                                if Date.now > notifs[index].date {
                                    UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notifs[index].uuid.uuidString])
                                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notifs[index].uuid.uuidString])
                                    print(notifs[index].uuid.uuidString)
                                    notifs.remove(at: index)
                                }else{
                                    showingAlert = true
                                }
                                
                            } label: {
                                stupidDelete()
                            }.alert("Sorry, this notification cannot be updated or deleted until its beginning date has passed.", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                        }
                        .padding(.bottom, -10)
                    } .sheet(isPresented: $showSheet) {
                        EmptyView()
                    }
              
            }.padding(.bottom, 30)
        }
    }
}
