//  Created by Matias Riveros-Amado on 10/20/24.


import SwiftUI
import UserNotifications
import Foundation

struct notifListView: View {
    @Namespace private var animation
    @Environment(\.dismiss) private var dismiss
    @StateObject private var notifs = Store.shared.notifs
    //@StateObject var interactions = interactionStore.shared.interactions

    @State var editing: Bool = false
    
    
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    init() {
        requestNotificationPermissions()
    }
    
    func requestNotificationPermissions() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error requesting notifications permission: \(error)")
            }
        }
    }
    
    
    
    
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                

                if editing {
                    editingNotif()
                        .matchedGeometryEffect(id: "Shape", in: animation)
                        .padding(.top, 160)
                }
                else{
                    indivNotif()
                        .matchedGeometryEffect(id: "Shape", in: animation)
                        .padding(.top, 160)
                }
                /*
                Button("Reset"){
                    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    UNUserNotificationCenter.current()
                    .removeAllDeliveredNotifications()
                    Store.shared.clear()
                    dismiss()
                }
                 */
                NavigationLink {
                    options_notifs()
                } label: {
                    ZStack {
                        Rectangle()
                            .fill(Color("greens"))
                            .frame(width: 350, height: 60)
                            .cornerRadius(10)
                            .padding([.top], 20)
                            .padding(.bottom, -15)
                        
                        Text("Add New Notification")
                            .foregroundStyle(.white)
                            .padding([.top], 20)
                            .padding(.bottom, -15)
                    }
                }
                HStack{
                    Button(action: {
                        print(NotifSaver().count)
                       
                         
                        
                         
                        withAnimation {
                            editing.toggle()
                        }
                        print(editing)
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("reds"))
                                .frame(width: 172, height: 50)
                            if editing {
                                Text("Done").foregroundStyle(.white)
                            }
                            else{
                                Text("Edit").foregroundStyle(.white)
                            }
                        }
                    }
                    )
                    .padding(.top, 20)
                    .padding(.bottom, 35)
                    .navigationTitle("Notifications")
                    
                    Button(action: {
                        dismiss()
                    }, label: { ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.red)
                            .frame(width: 172, height: 50)
                        Text("Return").foregroundStyle(.white)
                    }})
                    .padding(.top, 20)
                    .padding(.bottom, 35)
                    .navigationTitle("Notifications")
                    
                   
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("Background"))
                .edgesIgnoringSafeArea(.all)
        }
        
        .font(Font.custom("RabbidHighwaySignII", size: 18, relativeTo: .subheadline))
        
        .navigationBarBackButtonHidden(true)
        
    }
    
    
}

#Preview {
    notifListView()
}
