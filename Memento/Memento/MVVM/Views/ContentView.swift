//  Created by Matias Riveros-Amado on 10/13/24.




import SwiftUI
import SwiftData


@main
struct YourApp: App {
 
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    //.modelContainer(for: journal.self)
  }
}


struct ContentView: View {
    @AppStorage("welcomeSheetShowing") var welcomeSheetShowing: Bool = true
    private var height: CGFloat = 364
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        NavigationView{
            ZStack{
                ScrollView{
                    
                    HStack(spacing: -75){
                        Text("Memento")
                            .font(Font.custom("RabbidHighwaySignII", size: 45, relativeTo: .largeTitle))
                            .foregroundStyle(Color("purples"))
                            .frame(width: 300)
                            .opacity(0.5)
                        
                        Text("Memento")
                            .font(Font.custom("RabbidHighwaySignII", size: 45, relativeTo: .largeTitle))
                            .foregroundStyle(Color("blacks"))
                            .frame(width: 300)
                        Text("Memento")
                            .font(Font.custom("RabbidHighwaySignII", size: 45, relativeTo: .largeTitle))
                            .opacity(0.5)
                            .frame(width: 300)
                            .foregroundStyle(Color("reds"))
                        
                    }.padding(.top, 150)
                        .padding(.bottom, 30)
                    
                    /*      NavigationLink {
                     tester()
                     } label: {
                     ZStack{
                     RoundedRectangle(cornerRadius: 10)
                     .fill(Color("blacks"))
                     .frame(width: 200, height: 100)
                     Text("Insights")
                     .foregroundStyle(Color("Background"))
                     }
                     }
                     
                     */
                    NavigationLink(destination: notifListView(),
                                   label: { ZStack{
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color("reds"))
                            .frame(width: 375, height:150)
                        HStack{
                            Text("Notifications")
                                .font(Font.custom("RabbidHighwaySignII", size: 35))
                                .bold()
                                .font(.title)
                                .frame(width: 240)
                                .foregroundStyle(Color("Background"))
                                .padding(.trailing, 20)
                            
                            Image(systemName: "bell")
                                .resizable()
                                .aspectRatio(1, contentMode: .fit)
                                .frame(width: 140, height: 140)
                                .padding(.trailing, -90)
                                .padding(.leading, -10)
                                .foregroundStyle(Color("Background"))
                        }
                    }
                    })
                    NavigationLink(destination: MemoryJournalView(),
                                   label: { ZStack{
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color("blacks"))
                            .frame(width: 375, height:150)
                        HStack{
                            Image(systemName: "photo.on.rectangle")
                                .resizable()
                                .aspectRatio(1.2, contentMode: .fit)
                                .frame(width: 140, height: 140)
                                .padding(.trailing, 10)
                                .padding(.leading, -110)
                                .foregroundStyle(Color("Background"))
                            
                            Text("Photo Journal")
                                .font(Font.custom("RabbidHighwaySignII", size: 35))
                                .bold()
                                .font(.title)
                                .frame(width: 200)
                                .foregroundStyle(Color("Background"))
                                .padding(.trailing, -70)
                        }
                    }
                    })
                    NavigationLink(destination:   gamesView(),
                                   label: { ZStack{
                        RoundedRectangle(cornerRadius: 50)
                            .fill(Color("purples"))
                            .frame(width: 375, height:150)
                        HStack{
                            Text("Brain Games")
                                .font(Font.custom("RabbidHighwaySignII", size: 35))
                                .bold()
                                .font(.title)
                                .frame(width: 240)
                                .foregroundStyle(Color("Background"))
                                .padding(.trailing, 10)
                                .padding(.leading, -20)
                            
                            Image(systemName: "brain.filled.head.profile")
                                .resizable()
                                .aspectRatio(0.9, contentMode: .fit)
                                .frame(width: 140, height: 140)
                                .padding(.leading, -5)
                                .padding(.trailing, -110)
                                .foregroundStyle(Color("Background"))
                        }
                    }
                    }
                    ).padding(.bottom, 50)
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color("Background"))
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    HStack{
                        
                        Button {
                            welcomeSheetShowing = true
                        } label: {
                            Image(systemName: "questionmark.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }.foregroundStyle(.blacks)
                    }
                }.padding(.leading, 320)
                    .padding(.bottom, 700)
            }
            .navigationBarBackButtonHidden(true)
            .sheet(isPresented: $welcomeSheetShowing) {
                HomeScreen(welcomeSheetShowing: $welcomeSheetShowing).interactiveDismissDisabled()
            }
        }
    }
}
