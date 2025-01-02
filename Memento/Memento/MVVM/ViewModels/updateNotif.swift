//  Created by Matias Riveros-Amado on 10/28/24.


import SwiftUI
import UIKit


struct updateNotif: View {
    @Environment(\.dismiss) var dismiss
    @StateObject  var notifs = Store.shared.notifs
    @State private var editing: Bool = true

    @State var index: Int
    @State var label: String
    @State var date: Date = Date()
    @State var description: String
    @State var allowed: Bool = false
    
    @State var timeRepeatMins: String = ""
    @State var timeRepeatDays: String = ""
    @State var timeRepeatHours: String = ""
    @State private var showingAlert = true
    @Binding var showSheet: Bool
    @FocusState var isInputActive: Bool
    
    //curently not in use
    @State var isEnabled: Bool
    @State var selectedWeekdays: Set<Int>
    @State var allowDesc: Bool
 
    let weekdays = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]
    
    var body: some View {
        
        @State var timeInt: Int = ((Int(timeRepeatHours) ?? 0)*60) + (Int(timeRepeatMins) ?? 0) + (Int(timeRepeatDays) ?? 0)
        
        ScrollView{
            VStack {
                Text("Update Notification")
                    .padding(.top, 110)
                    .padding(.bottom, -10)
                
                    .font(Font.custom("RabbidHighwaySignII", size: 30, relativeTo: .largeTitle))
                    .foregroundStyle(Color(.white))

                ZStack{
                    
                    HStack{
                        Text("Label: ")
                            .font(Font.custom("RabbidHighwaySignII", size: 25, relativeTo: .subheadline))
                            .foregroundStyle(.white)
                        TextField("Enter Notification Label", text: $label)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: 200)
                            .focused($isInputActive)
                            .font(Font.custom("RabbidHighwaySignII", size: 20, relativeTo: .subheadline))
                            .padding(.horizontal)
                            .padding([.top, .bottom], 40)
                            .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                            .frame(width: 200)
                        
                    }
                }
                .padding(.bottom, -30)
// repetition determination
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 40)
                        .fill(Color("Background"))
                        .frame(width: 280, height: 200)
                    
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
                            // this toolbar with the done button is throwing an error because swiftui autolayout is bugged, and this forces me to use uikit to create the layour myself
                            
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
                ZStack{
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("Background"))
                        .frame(width: 280, height: 260)
                        .padding(.top, 10)
                    VStack{ Toggle("Enable description", isOn: $allowDesc)
                            .toggleStyle(SwitchToggleStyle(tint: Color("reds")))
                            .font(Font.custom("RabbidHighwaySignII", size: 20, relativeTo: .subheadline))
                            .frame(width: 250)
                            .scaleEffect(0.9)
                            .font(.body).bold(false)
                        
// description determination
                        if allowDesc {
                            Text("Enter description:")
                                .font(Font.custom("RabbidHighwaySignII", size: 15, relativeTo: .subheadline))
                                .padding(.top, 20)
                            
                            TextEditor(text: $description)
                                .focused($isInputActive)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                                .frame(width: 250)
                                .padding([.leading, .trailing])
                        }else{
                            Text("Enter description:")
                                .font(Font.custom("RabbidHighwaySignII", size: 15, relativeTo: .subheadline))
                                .padding(.top, 20)
                                .opacity(0.4)
                            
                            TextEditor(text: $description)
                                .foregroundStyle(Color.gray)
                                .frame(width: 250)
                                .padding(.top, 0)
                                .padding([.leading, .trailing])
                                .disabled(true)  
                        }}.frame(height: 200).font(Font.custom("RabbidHighwaySignII", size: 20, relativeTo: .subheadline))}.padding(.bottom, -16)
                
                HStack(spacing: 50){
                    
                    Button("Update") {

                        
//safety checks
                        
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
                        

                        if timeRepeatDays.isEmpty {
                            timeRepeatDays = "0"
                        }else{
                            timeRepeatDays = timeRepeatDays
                        }
                        if allowDesc{
                            description = description
                        } else {
                            description = ""
                        }
                        @State var totaltime: String = "Repeats every " + timeRepeatDays + " days, " + timeRepeatHours + " hours, " + timeRepeatMins + " minutes."

//action
                        
                        Store.shared.updating(index: index, newLabel: label, newDate: date, newDesc: description, timeRepeat: totaltime)
                        notifs.refresh()
                        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [notifs[index].uuid.uuidString])
                        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notifs[index].uuid.uuidString])
                        initialNotifCreations(date: date, isEnabled: isEnabled, allowDesc: allowDesc, selectedWeekdays: selectedWeekdays, label: label, description: description)
                        notifCreationsWithDelay(ids: notifs[index].uuid.uuidString, date: date, timeRepeatDays: timeRepeatDays, timeRepeatHours: timeRepeatHours, timeRepeatMins: timeRepeatMins, isEnabled: isEnabled, allowDesc: allowDesc, selectedWeekdays: selectedWeekdays, label: label, description: description)
                        dismiss()
                        
                    }.disabled(timeInt < 1 || label.isEmpty)
                    
                        .alert("Sorry, this notification cannot be updated or deleted until its beginning date has passed.", isPresented: $showingAlert) {
                            Button("OK", role: .cancel) { }
                        }
                    
                        .foregroundStyle(.white)
                        .font(Font.custom("RabbidHighwaySignII", size: 23, relativeTo: .headline)).bold()
                    
                    Button("Cancel"){
                        dismiss()
                    }.foregroundStyle(.white)
                        .font(Font.custom("RabbidHighwaySignII", size: 23, relativeTo: .headline)).bold()
                }
                .padding(.top, 40)
                .padding(.bottom, 50)
            }.toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
            .font(Font.custom("RabbidHighwaySignII", size: 18, relativeTo: .subheadline)).bold()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.reds))
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.reds))
            .edgesIgnoringSafeArea(.all)
    }
}

/*#Preview {
    editNotif(label: "dog", date: Date(), description: "hey", isEnabled: true, selectedWeekdays: [1, 2], allowDesc: true, showSheet: showSheet)
}*/
