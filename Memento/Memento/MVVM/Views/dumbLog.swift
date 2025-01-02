//  Created by Matias Riveros-Amado on 12/27/24.

/// This is intended for the insights feature.

import SwiftUI

struct dumbLog: View {
    var index: Int
    var label: String
    var formattedDate: String
    @State var completed: Bool
  //  @StateObject var interactions = interactionStore.shared.interactions
    
    var body: some View {
        
        HStack{
            ZStack{
                RoundedRectangle(cornerRadius: 15)
                    .foregroundStyle(Color.blacks)
                    .frame(width: 340, height: 70)
                
                HStack{
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(Color.blacks)
                        .frame(width: 100)
                    Spacer()
                }.frame(width: 340)
                HStack{
                    Text(label)
                        .multilineTextAlignment(.center)
                        .font(Font.custom("RabbidHighwaySignII", size: 17, relativeTo: .headline))
                        .foregroundStyle(Color.background)
                        .padding(.bottom, -3)
                        .padding(.leading, 10)
                        .frame(width: 140)
                    
                    Text("|")
                        .font(Font.custom("BPReplay", size: 40, relativeTo: .headline))
                        .foregroundStyle(Color.background)
                        .padding(.bottom, -6)
                        .padding(.leading, 2)

                    Text(formattedDate)
                        .font(Font.custom("BPReplay", size: 15, relativeTo: .subheadline))
                        .foregroundStyle(Color.background)
                    
                    Spacer()
                          
                        Image(systemName: "arrow.swap")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 30)
                            .foregroundStyle(Color.blacks)
                        Image(systemName: "trash.circle.fill")
                        
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 35)
                            .foregroundStyle(Color.blacks)
                            .padding(.trailing, 10)
                   
                }.frame(width: 340)
            }
        }
    }
}
/*
#Preview {
    dumbLog(label: "hey", formattedDate: "11:30 PM 12/24/25")
}
*/
