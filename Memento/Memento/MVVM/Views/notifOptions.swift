//  Created by Matias Riveros-Amado on 10/29/24.


import SwiftUI

struct options_notifs: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink(destination: Preset(label: "Drink Water"),
                               label: { ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color("reds"))
                        .frame(width: 375, height:150)
                    HStack{
                        Text("Drink Water")
                            .font(Font.custom("RabbidHighwaySignII", size: 35))
                            .bold()
                            .font(.title)
                            .frame(width: 240)
                            .foregroundStyle(Color("Background"))
                            .padding(.top, 5)
                            .padding(.trailing, 20)
                        
                        Image(systemName: "waterbottle")
                            .resizable()
                            .aspectRatio(0.5, contentMode: .fit)
                            .frame(width: 140, height: 140)
                            .padding(.leading, -40)
                            .padding(.trailing, -90)
                            .foregroundStyle(Color("Background"))
                    }
                }
                }).padding(.top, 30)
                NavigationLink(destination: Preset(label: "Take Medicine"),
                               label: { ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color("reds"))
                        .frame(width: 375, height:150)
                    HStack{
                        Image(systemName: "pills.fill")
                            .resizable()
                            .aspectRatio(1.1, contentMode: .fit)
                            .frame(width: 140, height: 140)
                            .padding(.trailing, 30)
                            .padding(.leading, -20)
                            .foregroundStyle(Color("Background"))
                        Text("Take Medicine")
                            .font(Font.custom("RabbidHighwaySignII", size: 35))
                            .bold()
                            .font(.title)
                            .frame(width: 180)
                            .foregroundStyle(Color("Background"))
                            .padding(.leading, 20)
                            .padding(.trailing, 30)
                    }
                }
                })
                NavigationLink(destination: Preset(label: "Get Food"),
                               label: { ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color("reds"))
                        .frame(width: 375, height:150)
                    HStack{
                        Text("Get Food")
                            .font(Font.custom("RabbidHighwaySignII", size: 35))
                            .bold()
                            .font(.title)
                            .frame(width: 240)
                            .foregroundStyle(Color("Background"))
                            .padding(.trailing, 10)
                            .padding(.leading, -20)
                        
                        Image(systemName: "fork.knife.circle")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 140, height: 140)
                            .padding(.leading, -10)
                            .padding(.trailing, -80)
                            .foregroundStyle(Color("Background"))
                    }
                }
                })
                NavigationLink(destination: newCustomNotif(),
                               label: { ZStack{
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color("reds"))
                        .frame(width: 375, height:150)
                    HStack{
                        
                        Image(systemName: "square.and.pencil")
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 140, height: 140)
                            .padding(.trailing, -10)
                            .padding(.leading, -140)
                            .padding(.bottom, 10)
                            .foregroundStyle(Color("Background"))
                        Text("Custom")
                            .font(Font.custom("RabbidHighwaySignII", size: 35))
                            .bold()
                            .font(.title)
                            .frame(width: 200)
                            .foregroundStyle(Color("Background"))
                            .padding(.trailing, -70)
                    }
                }
                })
                Button("Return") {
                    dismiss()
                }.padding(.top, 20)
                    .foregroundStyle(Color.red)
                    .font(Font.custom("RabbidHighwaySignII", size: 30, relativeTo: .headline))
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("Background"))
                .edgesIgnoringSafeArea(.all)
        }.navigationBarBackButtonHidden(true)
    }
}

#Preview {
    options_notifs()
}
