//  Created by Matias Riveros-Amado on 10/30/24.


import SwiftUI

struct QuickMathStart: View {
    @StateObject var viewModel = ReallyCoolMath()
    @Environment(\.presentationMode) var presentationMode

    
    var body: some View {

        NavigationView{
            VStack{
                Text("Quick Math")
                    .font(Font.custom("RabbidHighwaySignII", size: 50, relativeTo: .largeTitle))
                    .padding(.bottom, 30)
                
                NavigationLink(destination: QuickMathGame(),
                               label: {
                    Text("Start Game")
                        .font(Font.custom("RabbidHighwaySignII", size: 25))
                        .padding()
                        .background(Color("purples"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                })
                Button("Quit"){
            presentationMode.wrappedValue.dismiss()
        }.font(Font.custom("RabbidHighwaySignII", size: 25))
                .multilineTextAlignment(.trailing)
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.top, 20)
                .padding(.bottom, -50)
            }
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    QuickMathStart()
}
