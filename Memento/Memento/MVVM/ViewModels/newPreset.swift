//  Created by Matias Riveros-Amado on 10/29/24.


import SwiftUI





struct Preset: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var notifs = Store.shared.notifs
    @State private var label: String
    @State var date: Date = Date()
    @State var description: String = ""
    @State private var allowDesc: Bool = false
    @State var timeRepeatHours: String = ""
    @State var timeRepeatMins: String = ""
    @State var timeRepeatDays: String = ""

    
    @State var allowed: Bool = true
    @State var delay: Timer?
    
    @FocusState var isInputActive: Bool
    
    //currently not in use
    @State private var icon: String = ""
    @State private var isEnabled: Bool = true
    @State private var selectedWeekdays: Set<Int> = [0, 1, 2, 3, 4, 5, 6]
    
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    init(label: String) {
        self.label = label
        
    }
    
    var body: some View {
        @State var timeInt: Int = ((Int(timeRepeatHours) ?? 0)*60) + (Int(timeRepeatMins) ?? 0)
        
        ScrollView {
            VStack{
                //label at top
                HStack{
                    Text(label).padding(.top, 100).padding(.bottom, 20)
                        .font(Font.custom("RabbidHighwaySignII", size: 35, relativeTo: .title)).bold()
                        .foregroundStyle(Color("reds"))
                        .scaleEffect(1.1)
                        .padding(.top, 30)
                    Image(systemName: "waterbottle.fill")
                        .foregroundStyle(Color("reds"))
                        .foregroundStyle(Color("reds"))
                        .scaleEffect(2.8)
                        .padding(.leading, 30)
                        .padding(.top, 100)
                        .padding(.trailing, 5)
                }
                //cancel button
                Button("Cancel") {
                    //clearing
                    date = Date()
                    description = ""
                    dismiss()
                }.foregroundStyle(Color.red)
                    .font(Font.custom("RabbidHighwaySignII", size: 16, relativeTo: .subheadline))
                    .padding(.bottom, 10)
                    .scaleEffect(1.2)
                
                //repetition determination
                ZStack{
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("reds"))
                        .frame(width: 350, height: 190)
                        .padding(.top, 10)
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("Background"))
                        .frame(width: 280, height: 130)
                        .padding(.top, 10)
                    VStack{
                        HStack{
                            Text("Repeat every")
                            TextField("0", text: $timeRepeatHours)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 30)
                                .keyboardType(.numberPad)
                                .focused($isInputActive)
                                .toolbar {
                                    ToolbarItemGroup(placement: .keyboard) {
                                        Spacer()
                                        Button("Done") {
                                            isInputActive = false
                                        }
                                    }
                                }
                                .frame(width: 25)
                            Text("hours")
                        }.padding(.top, 10)
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
                
                // beginning date determination
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
                
                //description determination
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
                        //formatting for dumbEdit/dumbNotif
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
                        
                        //checks
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
                        
                        //variable introduction
                        @State var totaltime: String = "Repeats every " + timeRepeatHours + " hours, " + timeRepeatMins + " minutes."
                        
                        let newNotif = Notif(uuid: UUID(), date: date, enabled: isEnabled, descEnabled: allowDesc, repeatWeekdays: Array(selectedWeekdays).sorted(), mediaID: "", mediaLabel: "bell", label: label, description: description, timeRepeat: totaltime)
                        
                        //action!
                        notifs.add(newNotif)
                        Store.shared.save(notifs, notifying: newNotif, userInfo: [:])
                        initialNotifCreations(date: date, isEnabled: isEnabled, allowDesc: allowDesc, selectedWeekdays: selectedWeekdays, label: label, description: description)
                        notifCreationsWithDelay(ids: newNotif.uuid.uuidString, date: date, timeRepeatDays: "0", timeRepeatHours: timeRepeatHours, timeRepeatMins: timeRepeatMins, isEnabled: isEnabled, allowDesc: allowDesc, selectedWeekdays: selectedWeekdays, label: label, description: description)
                        
                        //clearing
                        date = Date()
                        description = ""
                        dismiss()
                    }
                    .padding()
                    .disabled(!allowed || timeInt < 1)
                    .font(Font.custom("RabbidHighwaySignII", size: 16, relativeTo: .headline))
                    
                    Button("Cancel") {
                        // clearing
                        date = Date()
                        description = ""
                        selectedWeekdays.removeAll()
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
    Preset(label: "Drink Water")
}
