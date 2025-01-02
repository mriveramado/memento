import SwiftUI

struct HomeScreen: View {
    @Binding var welcomeSheetShowing: Bool
    var body: some View {
        NavigationView{
            VStack{
                Text("Welcome to")
                    .font(Font.custom("RabbidHighwaySignII", size: 45, relativeTo: .largeTitle))
                    .foregroundStyle(Color("blacks"))
                
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
                    
                }
                NavigationLink {
                    Tutorial(welcomeSheetShowing: $welcomeSheetShowing)
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color("blacks"))
                            .frame(width: 100, height: 50)
                        Text("Begin")
                            .padding()
                            .foregroundStyle(Color("Background"))
                            .font(Font.custom("RabbidHighwaySignII", size: 20, relativeTo: .headline))
                    }
                }


            }
        }.navigationBarBackButtonHidden(true)
    }
}



struct Intros: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let image: Image
    let sizing: Double
}

let introViews = [
    Intros(title: "Notifications", subtitle: "These notifications are for reminding you of the small things that might slip your mind. There are preset notifications, but you can make your own custom notifications!", image: Image(systemName: "bell"), sizing: 1),
  //  Intros(title: "Insights", subtitle: "Keep track of how well you've been fulfilling your notifications and tasks.", image: Image(systemName: "chart.bar.xaxis.ascending.badge.clock"), sizing: 1.2),
    Intros(title: "Photo Journal", subtitle: "This is for saving your most prized memories. You can add descriptions to come back to later and relive your favorite moments!", image: Image(systemName: "photo.fill.on.rectangle.fill"), sizing: 1.2),
    Intros(title: "Brain Games", subtitle: "Keep your mind engaged and healthy with our brain games!", image: Image(systemName: "brain.head.profile.fill"), sizing: 0.8)
]

struct Tutorial: View {
    @Binding var welcomeSheetShowing: Bool
    
    var body: some View {
        VStack{
            TabView{
                
                ForEach(introViews) { intro in
                    VStack{
                       Text(intro.title)
                            .font(Font.custom("RabbidHighWaySignII", size: 35, relativeTo: .largeTitle))
                            .padding()
                        Text(intro.subtitle)
                                .font(Font.custom("BPReplay", size: 20, relativeTo: .title3))
                            .multilineTextAlignment(.center)
                            .padding()

                        intro.image
                            .resizable()
                            .aspectRatio(intro.sizing, contentMode: .fit) // Set a custom aspect ratio
                            .frame(width: 100, height: 100)
                            .padding()
                        

                    }
                    
                }
            }.tabViewStyle(.page)
                .onAppear{
                    UIPageControl.appearance().currentPageIndicatorTintColor = .blacks
                    UIPageControl.appearance().pageIndicatorTintColor = .systemGray

                }
            Button {
                welcomeSheetShowing.toggle()
            } label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(.blacks)
                        .frame(width: 350, height: 60)
                    Text("Done") 
                        .foregroundStyle(Color("Background"))
                        .font(Font.custom("RabbidHighWaySignII", size: 20, relativeTo: .title3))
                        
                }
            }
                .padding()

        }
        
    }
}


