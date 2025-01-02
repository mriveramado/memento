//  Created by Matias Riveros-Amado on 10/30/24.


import SwiftUI

struct gamesView: View {
    @Environment(\.presentationMode) var presentationMode
  

    var body: some View {

        
            
            NavigationView{
                VStack{
                ScrollView(.horizontal){
                    HStack{
                        NavigationLink(destination: GridGame(),
                                       label:  {
                            ZStack{
                                Rectangle().frame(width: 350, height: 600).cornerRadius(10).foregroundStyle(Color("purples"))
                                VStack{
                                    Text("Memory Grid")                            .font(Font.custom("RabbidHighwaySignII", size: 45, relativeTo: .largeTitle))
                                        .foregroundStyle(Color("Background"))
                                    Image(systemName:"square.grid.3x3.middle.filled")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit) // Set a custom aspect ratio
                                        .frame(width: 140, height: 140)
                                        .padding(.bottom, -30)
                                        .padding(.top, 50)
                                        .foregroundStyle(Color("Background"))
                                }
                            }
                        }).padding(.leading, 10)
                        NavigationLink(destination: QuickMathStart(),
                                       label:  {
                            ZStack{
                                Rectangle().frame(width: 350, height: 600).cornerRadius(10).foregroundStyle(Color("purples"))
                                VStack{
                                    Text("Quick Math")                            .font(Font.custom("RabbidHighwaySignII", size: 45, relativeTo: .largeTitle))
                                        .foregroundStyle(Color("Background"))
                                    Image(systemName:"timer")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit) // Set a custom aspect ratio
                                        .frame(width: 140, height: 140)
                                        .padding(.bottom, -30)
                                        .padding(.top, 50)
                                        .foregroundStyle(Color("Background"))
                                }
                            }
                        })
                        
                    }
                   
                }
                    HStack{
                        Spacer()
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
                        .padding(.trailing, 20)
                        }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("Background"))
                    .edgesIgnoringSafeArea(.all)

            
            
                
        }.navigationBarBackButtonHidden(true)
            
    }
}
#Preview {
    gamesView()
}
