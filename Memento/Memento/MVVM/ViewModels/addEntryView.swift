//  Created by Julia Min on 10/26/24.
// Edited by Matias Riveros-Amado



import SwiftUI
import UIKit
import PhotosUI

struct addEntryView: View {
    @State private var showingImagePicker = false
    @Binding var journalEntries: [JournalEntry]
    @Binding var isPresented: Bool
    @State private var newCaption = ""
    @State private var selectedImage: UIImage?
    @State private var date: Date = Date()
    @State private var allowedDate: Bool = false
    @State private var allowDesc: Bool = false
    @State private var description: String = ""
    @FocusState var isInputActive: Bool

    
    @State var selectedItems: [PhotosPickerItem] = []
    @State var data: Data?
    
    // This declares selectedImage as an optional variable of type UIImage. The question mark (?) signifies that selectedImage can hold either a UIImage value or nil.
    // When you declare selectedImage like this without initializing it to any specific value, it is automatically set to nil by default. This means that until you assign it an actual UIImage (for example, when a user selects an image), selectedImage will be nil.

    var body: some View {
        VStack {
            Text("Add New Entry")
                .font(Font.custom("RabbidHighwaySignII", size: 25, relativeTo: .title))
                .padding(.top, 30)

            Button {
                print("Tapped")
                showingImagePicker = true
                // Logic to select an image (use UIImagePickerController or another method.
                // Could replace this with actual image selection logic
            } label: {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 300)
                        .clipped()
                        .cornerRadius(10)
                    } else {
                        ZStack {
                            Rectangle()
                                .fill(.gray)
                                .frame(height: 400)
                                .cornerRadius(10)
                            Text("Select Image")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    }
            }
            .padding(20)
            .padding(.bottom, -20)
            
            ScrollView{
                
                TextField("Enter caption", text: $newCaption)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isInputActive = false
                                
                            }
                        }
                    }
                    .padding()
                    
                
                // Optional Binding: (if let image = selectedImage): This line checks if selectedImage contains a valid UIImage. If selectedImage is not nil, the code inside the block will execute. This is a common Swift pattern to safely unwrap optionals.
                
                // In the context of optional binding, the name you choose for the unwrapped variable (in this case, image) is arbitrary. You can name it whatever you like, as long as it follows Swift's naming conventions. The key point is that this name is a temporary variable that holds the unwrapped value of the optional for the duration of the scope in which it's defined.
                
                //  If selectedImage is nil, the code inside the if block will not execute, and there will be no action taken—there's no else clause needed if you don't want to do anything when the optional is nil.
                Toggle(isOn: $allowedDate) {
                    Text("Allow date?")
                    
                }.frame(width: 200)
                if allowedDate{
                    DatePicker("Date", selection: $date, in: ...Date.now, displayedComponents: [.date])
                        .frame(width: 200, height: 30)
                        .padding(.vertical, 15)
                    
                    
                }else{
                    Text("(Date disabled)")
                        .foregroundStyle(.gray)
                        .frame(height: 30)
                        .padding(.vertical, 15)
                    
                }
                
                VStack{
                    Toggle("Enable description", isOn: $allowDesc)
                        .toggleStyle(SwitchToggleStyle(tint: Color("Background")))
                        .font(Font.custom("RabbidHighwaySignII", size: 20, relativeTo: .subheadline))
                        .frame(width: 250)
                        .scaleEffect(0.9)
                        
                    if allowDesc {
                        Text("Enter description:")
                            .font(Font.custom("RabbidHighwaySignII", size: 15, relativeTo: .subheadline))
                            .padding(.top, 20)
                        
                        TextEditor(text: $description)
                            .focused($isInputActive)
                            .toolbar {
                                ToolbarItemGroup(placement: .keyboard) {
                                    Spacer()
                                    Button("Done") {
                                        isInputActive = false
                                        
                                    }
                                }
                            }
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
                            .focused($isInputActive)
                            .border(Color.gray, width: 0.5)
                            .frame(width: 250)
                            .padding(.top, 0)
                            .padding([.leading, .trailing])
                            .disabled(true)
                        
                    }
                }.frame(height: 200)
                    .padding(.bottom)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") {
                                isInputActive = false
                                
                            }
                        }
                    }
                HStack{
                    if selectedImage != nil {
                        
                        Button("Save") {
                            if let selectedImage = selectedImage {
                                let newEntry = JournalEntry(image: selectedImage, caption: newCaption, date: Date(), allowedDate: allowedDate, description: description)
                                journalEntries.insert(newEntry, at: 0)
                            }
                            newCaption = ""
                            selectedImage = nil
                            isPresented = false
                            description = ""
                        }
                        .foregroundStyle(Color.background)
                        .disabled(selectedImage == nil)
                        .padding()
                        .background(.blacks)
                        .cornerRadius(10)
                    }else{
                        Text("Save")
                            .foregroundStyle(.gray)
                            .disabled(selectedImage == nil)
                            .padding()
                            .background(.blacks)
                            .cornerRadius(10)
                    }
                    
                    Button("Cancel") {
                        newCaption = ""
                        selectedImage = nil
                        isPresented = false
                        description = ""
                    }
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(.red)
                    .cornerRadius(10)
                }
                
            }.toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isInputActive = false
                        
                    }
                }
            }
        }
        
        .padding() // Added padding for the entire VStack for better layout
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(selectedImage: $selectedImage)
        }
        
    }
}
