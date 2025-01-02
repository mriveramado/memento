//  Created by Matias Riveros-Amado on 10/30/24.


import SwiftUI

struct notifDetails: View {
    @Binding var notif: Notif
    let weekdays: [String] = []
    @State var padding: Int = 0
    var setFor: String = ""
    
    
    var body: some View {
        
        VStack {
            if !notif.description.isEmpty {
                Text(notif.label)
                    .font(Font.custom("RabbidHighwaySignII", size: 42, relativeTo: .largeTitle))
                    .foregroundStyle(.reds)
                    .padding(20)
                    .bold()
                    .padding(.top, 160)
            }else{
                Text(notif.label)
                    .font(Font.custom("RabbidHighwaySignII", size: 42, relativeTo: .largeTitle))
                    .foregroundStyle(.reds)
                    .padding(20)
                    .bold()
            }
            
            Text("Set to begin at " + notif.formattedTime).foregroundStyle(.white)
                .font(Font.custom("BPReplay", size: 25, relativeTo: .title2))
                .frame(width: 350)
                .padding(.bottom, 5)
            
            Text(notif.timeRepeat)
                .frame(width: 300, alignment: .center)
                .font(Font.custom("BPreplay", size: 25, relativeTo: .title2))
                .multilineTextAlignment(.center)
            
            if !notif.description.isEmpty {
                Text("Description:")
                    .font(Font.custom("BPreplay", size: 20, relativeTo: .title3))
                    .padding([.top, .bottom], 20)
                ScrollView {
                    HStack {
                        Text(notif.description)
                            .frame(width: 350)
                            .multilineTextAlignment(.leading)
                            .padding()
                            .background(Color.reds.opacity(0.2), in: RoundedRectangle(cornerRadius: 8))
                            .lineLimit(nil)
                    }
                }
                Spacer()
            }else{
                Text("No description set")
                    .font(Font.custom("BPreplay", size: 20, relativeTo: .title3))
                    .padding(.top, 20)
                    .bold()
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .edgesIgnoringSafeArea(.all)
    }
}
