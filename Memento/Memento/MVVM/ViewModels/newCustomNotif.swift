//  Created by Matias Riveros-Amado on 10/29/24.


import SwiftUI
import Foundation




struct newCustomNotif: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var notifs = Store.shared.notifs
  //  @StateObject var interactions = interactionStore.shared.interactions

    @State var label: String = ""
    @State var date: Date = Date()
    @State var description: String = ""
    @State var allowDesc: Bool = false
    @State var timeRepeatHours: String = ""
    @State var timeRepeatMins: String = ""
    @State var timeRepeatDays: String = ""
    @State var delay: Timer?
    @State var allowed: Bool = true
    @FocusState var isInputActive: Bool
    
    // All references to the interaction feature had to be commented out so the rest of the app could work as intended.
    
    
  /*
    func interactionLog(label: String, timeRepeatDays: Double, timeRepeatHours: Double, timeRepeatMins: Double, date: Date, id: String) -> Void{
        @State var timer: Timer?
        @StateObject var notifs = Store.shared.notifs

        @State var interval: Double = (timeRepeatDays * 3600 * 24) + (timeRepeatHours * 3600 ) + (timeRepeatMins * 60)
        @StateObject var interactions = interactionStore.shared.interactions
        let test = interaction(label: label, completed: true, id: "gey")
        print(":bropo")
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            print("hpiioj")
            if notifs.containsID(id) && notifs.containsLabel(label){
                interactions.add(test)
                interactionStore.shared.interactions.refresh()
                print("yepers")
            }else{
                if let timer {
                    timer.invalidate()
                    print("bye bye")
                } else {
                    print("something has gone horrifically wrong")
                }
                
            }
        }
    }
    
    */
    // variables currently not in use, but are a part of the notif init. i may use them later
    @State var isEnabled: Bool = true
    @State var selectedWeekdays: Set<Int> = [0, 1, 2, 3, 4, 5, 6]
  
    var body: some View {
        //making sure that we arent setting an unanallowed time
        @State var timeInt: Int = ((Int(timeRepeatHours) ?? 0)*3600) + ((Int(timeRepeatMins) ?? 0)*60) + ((Int(timeRepeatDays) ?? 0)*3600*24)
        
        
        ScrollView {
            //top buttons
            VStack{
                Text("Custom Notification").padding(.top, 100).padding(.bottom, 20)
                    .font(Font.custom("RabbidHighwaySignII", size: 35, relativeTo: .title)).bold()
                    .foregroundStyle(Color("reds"))
                    .scaleEffect(0.8)
                    .padding(.top, 30)
                Button("Cancel") {
                    label = ""
                    date = Date()
                    description = ""
                    selectedWeekdays.removeAll()
                    dismiss()
                }.foregroundStyle(Color.red)
                    .font(Font.custom("RabbidHighwaySignII", size: 16, relativeTo: .subheadline))
                    .padding(.bottom, 10)
                    .scaleEffect(1.2)
                
                // label determination
                ZStack{
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color("reds"))
                        .frame(width: 320, height: 80)
                    TextField("Enter Notification Label", text: $label)
                    
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                        .frame(width: 250)
                        .focused($isInputActive)
                        .font(Font.custom("RabbidHighwaySignII", size: 20, relativeTo: .subheadline))
                    
                    
                    
                        .padding(.horizontal)
                        .padding([.top, .bottom], 40)
                        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                        .frame(width: 300)
                }
                .padding(.bottom, -30)
                
                
                // repetition determination
                ZStack{
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("reds"))
                        .frame(width: 340, height: 260)
                        .padding(.top, 10)
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("Background"))
                        .frame(width: 280, height: 200)
                        .padding(.top, 10)
                    
                    VStack{
                        HStack{
                            Text("Repeat every")
                            TextField("0", text: $timeRepeatDays)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 30)
                                .keyboardType(.numberPad)
                                .focused($isInputActive)
                            Text("days")
                        }
                        .padding(.top, 10)
                        
                        HStack{
                            Text("Repeat every")
                            TextField("0", text: $timeRepeatHours)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 30)
                                .keyboardType(.numberPad)
                                .focused($isInputActive)
                            // this toolbar with the done button is throwing an error because swiftui autolayout is bugged, and this forces me to use uikit to create the layour myself. The only real issue is in the debugger, the app still runs perfectly fine
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button("Done") {
                                            isInputActive = false
                                            
                                        }
                                    }
                                }
                            Text("hours")
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 15)
                        
                        HStack{
                            Text("Repeat every")
                            TextField("0", text: $timeRepeatMins)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 30)
                                .keyboardType(.numberPad)
                                .focused($isInputActive)
                                .frame(width: 25)
                            Text("minutes")
                        }
                    }
                }.padding(.bottom, -16)
                
                
                //initial date determination
                ZStack{
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("reds"))
                        .frame(width: 330, height: 230)
                        .padding(.top, 10)
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color("Background"))
                        .frame(width: 280, height: 180)
                        .padding(.top, 10)
                    
                    VStack{
                        Text("Starting from:")
                        
                        DatePicker("Time", selection: $date, in: Date.now..., displayedComponents: [.hourAndMinute])
                            .padding(.top, 10)
                            .padding([.leading, .trailing])
                        
                        DatePicker("Date", selection: $date, in: Date.now..., displayedComponents: [.date])
                            .padding(.top, 10)
                            .padding([.leading, .trailing])
                    }.frame(width: 230)
                }.padding(.bottom, -16)
                
                // description determination
                ZStack{
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("reds"))
                        .frame(width: 350, height: 320)
                        .padding(.top, 10)
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("Background"))
                        .frame(width: 280, height: 260)
                        .padding(.top, 10)
                    VStack{
                        Toggle("Enable description", isOn: $allowDesc)
                            .toggleStyle(SwitchToggleStyle(tint: Color("reds")))
                            .font(Font.custom("RabbidHighwaySignII", size: 20, relativeTo: .subheadline))
                            .frame(width: 250)
                            .scaleEffect(0.9)
                            .font(.body).bold(false)
                        if allowDesc {
                            Text("Enter description:")
                                .font(Font.custom("RabbidHighwaySignII", size: 15, relativeTo: .subheadline))
                                .padding(.top, 20)
                            
                            TextEditor(text: $description)
                                .focused($isInputActive)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                                .border(Color.gray, width: 0.5)
                                .frame(width: 250)
                                .padding([.leading, .trailing])
                        }else{
                            Text("Enter description:")
                                .font(Font.custom("RabbidHighwaySignII", size: 15, relativeTo: .subheadline))
                                .padding(.top, 20)
                                .opacity(0.4)
                            
                            TextEditor(text: $description)
                                .foregroundStyle(Color.gray)
                                .border(Color.gray, width: 0.5)
                                .frame(width: 250)
                                .padding(.top, 0)
                                .padding([.leading, .trailing])
                                .disabled(true)
                        }
                    }.frame(height: 200)
                        .font(Font.custom("RabbidHighwaySignII", size: 20, relativeTo: .subheadline))
                }
                .padding(.bottom, -16)
                
// bottom buttons
                HStack{
                    Button("Add Notification") {
                        
                        //formatting for dumbNotif/dumbEdit
                        if timeRepeatMins.isEmpty {
                            timeRepeatMins = "0"
                        }else{
                            timeRepeatMins = timeRepeatMins
                        }
                        
                        if timeRepeatHours.isEmpty {
                            timeRepeatHours = "0"
                        }else{
                            timeRepeatHours = timeRepeatHours
                        }
                        
                        //safety checks
                        if timeRepeatDays.isEmpty {
                            timeRepeatDays = "0"
                        }else{
                            timeRepeatDays = timeRepeatDays
                        }
                        
                        if let number = Int(timeRepeatMins) {
                            print("Converted to integer: \(number)")
                            allowed = true
                        } else {
                            allowed = false
                        }
                        
                        if let numba = Int(timeRepeatHours) {
                            print("Converted to integer: \(numba)")
                            allowed = true
                        } else {
                            allowed = false
                        }
                        
                        // variable introduction
                        @State var totaltime: String = "Repeats every " + timeRepeatDays + " days, " + timeRepeatHours + " hours, " + timeRepeatMins + " minutes."

                        //idk what the warning is talking about,i literally use it 5 lines later
                        //let timer: Timer
                      // var interval: Double = Double(timeRepeatDays) + Double(timeRepeatMins) + Double(timeRepeatHours)
                                // let interval = Double(timeInt)
                        
                        
                        let newNotif = Notif(uuid: UUID(), date: date, enabled: isEnabled, descEnabled: allowDesc, repeatWeekdays: Array(selectedWeekdays).sorted(), mediaID: "", mediaLabel: "bell", label: label, description: description, timeRepeat: totaltime)
                       
                      // let first = interaction(date: Date(), label: label, completed: false, id: newNotif.uuid.uuidString)
                        //action!
                        
                        notifs.add(newNotif)
                        Store.shared.save(notifs, notifying: newNotif, userInfo: [:])
                        initialNotifCreations(date: date, isEnabled: isEnabled, allowDesc: allowDesc, selectedWeekdays: selectedWeekdays, label: label, description: description)
                        notifCreationsWithDelay(ids: newNotif.uuid.uuidString, date: date, timeRepeatDays: timeRepeatDays, timeRepeatHours: timeRepeatHours, timeRepeatMins: timeRepeatMins, isEnabled: isEnabled, allowDesc: allowDesc, selectedWeekdays: selectedWeekdays, label: label, description: description)
                  //      interactions.method(label: label, id: newNotif.uuid.uuidString, interval: interval)
                       // interactions.add(first)
                        notifs.refresh()
                        
                /*        interactions.refresh()

                        
                        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                            print("fweh")
                            let repeater = interaction(date: Date(), label: label, completed: false, id: newNotif.uuid.uuidString)

                            if notifs.containsID(newNotif.uuid.uuidString) && notifs.containsLabel(label){
                                interactions.add(repeater)
                                //Store.Shared.interactions.refresh()
                                print("carticarticarti")
                            }else{
                                timer.invalidate()
                                print("siyuh")
                            }
                            
                        }
                        
                        */
                        //clearing
                        date = Date()
                        description = ""
                        dismiss()
                    }
                    .padding()
                    .disabled(!allowed || timeInt < 1 || label.isEmpty)
                    .font(Font.custom("RabbidHighwaySignII", size: 16, relativeTo: .headline))
                    
                    Button("Cancel") {
                        date = Date()
                        description = ""
                        dismiss()
                    }
                    .padding()
                    .foregroundStyle(Color.red)
                    .font(Font.custom("RabbidHighwaySignII", size: 16, relativeTo: .headline))
                }.padding(.bottom, 40)
                    .padding(.top, 20)
                    .scaleEffect(1.15)
            }.font(Font.custom("RabbidHighwaySignII", size: 18, relativeTo: .subheadline)).bold()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("Background"))
                .edgesIgnoringSafeArea(.all)
                .navigationBarBackButtonHidden(true)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .edgesIgnoringSafeArea(.all)
    }
}




#Preview {
    newCustomNotif()
}
