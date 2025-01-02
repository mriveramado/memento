//  Created by Julia Min on 10/26/24.
// Edited by Matias Riveros-Amado

import SwiftUI
import UIKit
import PhotosUI




struct MemoryJournalView: View {
    @Environment(\.modelContext) private var context
    
    @FocusState var isInputActive: Bool

    
    @State private var addEntry = false
    @State private var check: Int = 0
    @State private var index: Int = 0
    @State private var journalEntries: [JournalEntry] = [
        //      journal(image: UIImage(named: "photo1") ?? UIImage(), caption: "My daughter Daniela ❤️", date: Date(), allowedDate: true),
        //   journal(image: UIImage(named: "photo2") ?? UIImage(), caption: "My son Xander, his wife, and his granddaughters!", date: Date(), allowedDate: true)
    ]
    @Environment(\.dismiss) var dismiss
    
    enum Options: String, CaseIterable, Identifiable {
        case scroll, grid, random
        var id: Self { self }
    }
    @AppStorage("choices") var choice: Options = .scroll
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationStack{
            VStack {
                Text("Memory Journal")
                    .font(Font.custom("RabbidHighwaySignII", size: 35, relativeTo: .title))
                    .foregroundColor(.blacks)
                    .padding(.bottom, 20)
                    .padding(.top, -80)
                
                if journalEntries.isEmpty{
                    VStack{
                        Text("No entries yet!")
                        Text("Add one using the button below")
                    }
                    .frame(height: 400)
                }else{
                    if choice == .random {
                        Button {
                            while index == check{
                                if journalEntries.count > 1 {
                                    index = Int.random(in: 0..<journalEntries.count)
                                    print("hey")
                                    print(index)
                                    print(check)
                                }else{
                                    index = 0
                                    check = 0
                                    print("ew")
                                    break
                                }
                            }
                            check = index
                            print("hw")
                            
                        } label: {
                            indivMem(image: journalEntries[index].image, caption: journalEntries[index].caption, allowedDate: journalEntries[index].allowedDate, formattedDate: journalEntries[index].formattedDate, size: 300, font: 25, smallFont: 20)
                        }
                        .frame(height: 400)
                        
                    }else if choice == .grid {
                        ScrollView{
                            LazyVGrid(columns: adaptiveColumns, spacing: 20){
                                ForEach(journalEntries) { entry in
                                    NavigationLink {
                                        VStack{
                                            indivMem(image: entry.image, caption: "", allowedDate: entry.allowedDate, formattedDate: entry.formattedDate, size: 350, font: 20, smallFont: 20)
                                            Text(entry.caption)
                                                .font(Font.custom("BPReplay", size: 30, relativeTo: .title))
                                                .padding(.top, -60)
                                            if ((entry.description?.isEmpty) != nil) {
                                                Text(entry.description!)
                                                    .padding(.top, -60)
                                            }else{
                                            Text("No description set")
                                            }
                                        }
                                    } label: {
                                        indivMem(image: entry.image, caption: entry.caption, allowedDate: entry.allowedDate, formattedDate: entry.formattedDate, size: 180, font: 20, smallFont: 12)
                                    }

                                    
                                    
                                }
                            }.padding(.horizontal)
                        }.frame(height: 400)
                    } else if choice == .scroll {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(journalEntries) { entry in
                                    NavigationLink {
                                        indivMem(image: entry.image, caption: entry.caption, allowedDate: entry.allowedDate, formattedDate: entry.formattedDate, size: 350, font: 40, smallFont: 20)
                                    } label: {
                                        indivMem(image: entry.image, caption: entry.caption, allowedDate: entry.allowedDate, formattedDate: entry.formattedDate, size: 300, font: 25, smallFont: 20)
                                    }
                                }
                            }
                        }.frame(height: 400)
                            .padding(.horizontal)
                    } else {
                        Text("i haven't coded this yet lol")
                    }
                }
                
                VStack{
                    Picker("View as:", selection: $choice) {
                        ForEach(Options.allCases) { choice in
                            Text(choice.rawValue.capitalized)
                        }
                    }.pickerStyle(.segmented)
                        .frame(width: 225)
                        .padding(.bottom, 10)
                    Button {
                        addEntry = true
                    } label: {
                        Text("Add New Entry")
                            .frame(width: 280, height: 50)
                            .background(Color.blacks)
                            .foregroundColor(Color.background)
                            .font(Font.custom("RabbidHighwaySignII", size: 18, relativeTo: .headline))
                            .cornerRadius(10)
                        
                        
                        
                    }
                    .sheet(isPresented: $addEntry) {
                        // tells to watch for changes in addEntry; if it is true, do the code in the closure
                        addEntryView(journalEntries: $journalEntries, isPresented: $addEntry)
                            
                        // presents new view; binding $journalEntries allows journal entries array to be modified directly. parameter set in struct below
                    }
                    .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            addEntryView(journalEntries: $journalEntries, isPresented: $addEntry).isInputActive = false
                            
                        }
                    }
                }
                    Button(action: {
                        
                        
                        dismiss()
                    }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.red)
                                .frame(width: 172, height: 40)
                            Text("Return").foregroundStyle(.white)
                            
                        }
                        
                    }
                           
                    )
                }.padding(.top, 30)
                    .padding(.bottom, -90)
                
                    .font(Font.custom("RabbidHighwaySignII", size: 15, relativeTo: .subheadline))
                    .padding(.bottom, -45)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("Background"))
                .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
            
        }.navigationBarBackButtonHidden(true)
    }
}

// originally had this homeview to initialize when you clicked the button, but this has since been removed. perhaps we will add it back

/*
struct HomeView: View {
    @State private var showMemoryJournal = false
    @Environment(\.dismiss) var dismiss

    @State private var sampleEntries: [JournalEntry] = [
        JournalEntry(image: UIImage(named: "photo3") ?? UIImage(), caption: "My granddaughter Lillian!", date: Date()),
        JournalEntry(image: UIImage(named: "photo4") ?? UIImage(), caption: "Richard, me, and my family!", date: Date()),
        JournalEntry(image: UIImage(named: "photo5") ?? UIImage(), caption: "My son Karl!", date: Date()),
        JournalEntry(image: UIImage(named: "photo6") ?? UIImage(), caption: "Chiara, my daughter", date: Date()),
        JournalEntry(image: UIImage(named: "photo3") ?? UIImage(), caption: "My granddaughter Lillian!", date: Date()),
        JournalEntry(image: UIImage(named: "photo4") ?? UIImage(), caption: "Richard, me, and my family!", date: Date()),
        JournalEntry(image: UIImage(named: "photo5") ?? UIImage(), caption: "My son Karl!", date: Date()),
        JournalEntry(image: UIImage(named: "photo6") ?? UIImage(), caption: "Chiara, my daughter", date: Date())
        
    ]
    
    @State private var scrollOffset: CGFloat = 0 // Track vertical offset for scrolling
    let scrollTimer = Timer.publish(every: 0.03, on: .main, in: .common).autoconnect() // Adjust speed with interval

    var body: some View {
        VStack {
            
            Text("Welcome to the Memory Journal!")
                .font(.system(size: 35, weight: .medium, design: .serif))
                .foregroundColor(.blacks)
                .padding(.bottom, 10)
                .padding(.top, 20)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(sampleEntries) { entry in
                        VStack {
                            Image(uiImage: entry.image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 300, height: 300)
                                .clipped()
                                .cornerRadius(10)
                                    
                            Text(entry.caption)
                                .font(.system(size: 20, design: .serif))
                                .padding(.top, 25)
                                .lineLimit(nil)
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(maxWidth: 250, maxHeight: 40)
                                .foregroundColor(.blacks)
                                .padding(.bottom, 20)
                        }
                    }
                }
                .offset(y: scrollOffset) // Apply offset for scrolling
                .onReceive(scrollTimer) { _ in
                    withAnimation(.linear(duration: 0.03)) { // Smooth animation for each step
                        scrollOffset -= 1 // Move up by 1 point (adjust as needed)
                    }
                        // Reset scroll position for infinite scrolling
                    let contentHeight = CGFloat(sampleEntries.count * 316) // Adjust for image and spacing height
                    if scrollOffset < -contentHeight {
                        scrollOffset = UIScreen.main.bounds.height
                    }
                }
            }
            .padding(.bottom, 10)
    
            Button(action: {
                showMemoryJournal = true
            }) {
                Text("Get Started")
                    .font(Font.custom("RabbidHighwaySignII", size: 20, relativeTo: .headline))

                    .frame(width: 250, height: 60)
                    .background(.blacks)
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .cornerRadius(10)
            }
            Button(action: {
                
                
                dismiss()
            }, label: { ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.red)
                    .frame(width: 172, height: 40)
                Text("Return").foregroundStyle(.white)
            }})
            .font(Font.custom("RabbidHighwaySignII", size: 15, relativeTo: .subheadline))
            .padding(.top, -15)

            .padding()
            .fullScreenCover(isPresented: $showMemoryJournal) {
                MemoryJournalView()
            .transition(.slide)
                
                
            }.navigationBarBackButtonHidden(true)
        }
    }
}
*/
