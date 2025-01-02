//  Created by Matias Riveros-Amado on 11/29/24.


import SwiftUI

struct indivNotif: View {
    @StateObject private var notifs = Store.shared.notifs
    @State var editing: Bool = false
    var padding: CGFloat? = -10
    
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var body: some View {
        ScrollView{
            
            ForEach(0..<notifs.count, id: \.self) { index in
                    NavigationLink(destination: notifDetails(notif: Binding(
                        get: { notifs[index] },
                        set: { notifs[index] = $0 }
                    ))){
                                                        
                        dumbNotif(label: notifs[index].label, setFor: notifs[index].formattedTime, repetition: "\(notifs[index].timeRepeat)").padding(.bottom, padding)
                    }
            }.padding(.bottom, 30)
        }
    }
}

