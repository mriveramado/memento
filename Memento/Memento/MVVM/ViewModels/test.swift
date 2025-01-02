/*
import SwiftUI
import PhotosUI
import SwiftData

/// This testing file is for the interactions feature.


struct interactionLog: View{
    //THIS IS UGLY CODING, I APOLOGIZE. the problem is that i need the view to not only update the model (easy to do) and the view (even easier) but when you leave the view, i need it to stay synchronized. i tried a million things, but this was simply the easiest thing to do...
    // i actually do NOT know why this works
    @State var refresher: Int = 0
    @StateObject var interactions = interactionStore.shared.interactions

    var body: some View{
        ScrollView{
            VStack{
                Button{
                    refresher += 1

                } label: {
                    Text("Edit")
                        .foregroundStyle(.red)
                }
                if refresher % 2 == 0 {
                ForEach(0..<interactions.Count, id: \.self) { index in
                   
                    
                        HStack{
                            if interactions[index].completed{
                                
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(Color.greens)
                                    .frame(width: 35, height: 70)
                                    .padding(.trailing, -4)
                            }else{
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(Color.reds)
                                    .frame(width: 35, height: 70)
                                    .padding(.trailing, -4)
                            }
                            ZStack{
                                dumbLog(index: index, label: interactions[index].label, formattedDate: interactions[index].formattedTime + ", " + interactions[index].formattedDate, completed: interactions[index].completed)
                                HStack{
                                    Spacer()
                                    /*
                                    Button {
                                        //  print("yo houhouh" + String(completed))
                                        interactions.updating(index: index)
                                        interactions[index].completed.toggle()
                                        refresher += 1
                                        
                                        //    print("ya jtdudu " + String(completed))
                                        
                                        
                                    } label: {
                                        Image(systemName: "arrow.swap")
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 30)
                                            .foregroundStyle(Color.background)
                                    }
                                    */
                                    Image(systemName: "arrow.swap")
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: 30)
                                        .foregroundStyle(Color.blacks)
                                    
                                    Button {
                                        interactions.remove(at: index)
                                    } label: {
                                        Image(systemName: "trash.circle.fill")
                                        
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 35)
                                            .foregroundStyle(Color.red)
                                            .padding(.trailing, 10)
                                    }
                                }.frame(width: 340)
                            }
                        }
                    }
                        
                }else{
                    ForEach(0..<interactions.Count, id: \.self) { index in
                       
                        
                            HStack{
                                if interactions[index].completed{
                                    
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(Color.greens)
                                        .frame(width: 35, height: 70)
                                        .padding(.trailing, -4)
                                }else{
                                    RoundedRectangle(cornerRadius: 5)
                                        .foregroundStyle(Color.reds)
                                        .frame(width: 35, height: 70)
                                        .padding(.trailing, -4)
                                }
                                ZStack{
                                    dumbLog(index: index, label: interactions[index].label, formattedDate: interactions[index].formattedTime + ", " + interactions[index].formattedDate, completed: interactions[index].completed)
                                    HStack{
                                        Spacer()
                                        Button {
                                            //  print("yo houhouh" + String(completed))
                                            interactions[index].completed.toggle()
                                            refresher += 1
                                            //    print("ya jtdudu " + String(completed))
                                            
                                            
                                        } label: {
                                            Image(systemName: "arrow.swap")
                                                .resizable()
                                                .aspectRatio(1, contentMode: .fit)
                                                .frame(width: 30)
                                                .foregroundStyle(Color.red)
                                        }
                                        
                                        Button {
                                            interactions.remove(at: index)
                                        } label: {
                                            Image(systemName: "trash.circle.fill")
                                            
                                                .resizable()
                                                .aspectRatio(1, contentMode: .fit)
                                                .frame(width: 35)
                                                .foregroundStyle(Color.red)
                                                .padding(.trailing, 10)
                                        }
                                    }.frame(width: 340)
                                }
                            }
                        }
                }
                
            }
        }.frame(height: 200)
    }
    
}

struct tester: View{
    
    var body: some View {
        interactionLog().frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .edgesIgnoringSafeArea(.all)
    }
}


class timer{
    var timer = Timer()
    
    
}

*/
