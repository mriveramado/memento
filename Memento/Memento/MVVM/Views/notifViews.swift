//  Created by Matias Riveros-Amado on 11/29/24.


import SwiftUI

struct dumbNotif: View {
    var label: String
    var setFor: String
    var repetition: String?
    
    init(label: String, setFor: String, repetition: String? = nil) {
        self.label = label
        self.setFor = setFor
        self.repetition = repetition
    }
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15).foregroundStyle(.reds)
                .frame(width: 380, height: 175)
           
                VStack{
                    Text(label).foregroundStyle(.white)
                        .font(Font.custom("RabbidHighwaySignII", size: 35, relativeTo: .title2))
                        .padding(.bottom, 5)
                        
                    
                    VStack{
                        Text("Set to begin at " + setFor).foregroundStyle(.white)
                            .font(Font.custom("BPReplay", size: 20, relativeTo: .headline))
                            .frame(width: 350)
                            .padding(.bottom, 5)
                        
                        if repetition != nil{
                            Text("\(repetition!)").foregroundStyle(.white)
                                .font(Font.custom("BPReplay", size: 20, relativeTo: .headline))
                                .frame(width: 210)
                        }else{
                            Text("Does not repeat").foregroundStyle(.white)
                                .font(Font.custom("BPReplay", size: 20, relativeTo: .headline))
                                .frame(width: 210)
                        }
                    }
            }
        }
    }
}

struct stupidEdit: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 15).foregroundStyle(.purples)
                .frame(width: 110, height: 82)
            Image(systemName: "slider.vertical.3")
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 40, height: 40)
        }
    }
}

struct stupidDelete: View {
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 15).foregroundStyle(.red)
                .frame(width: 110, height: 83)
            Image(systemName: "trash.fill")
                .resizable()
                .aspectRatio(0.85, contentMode: .fit)
                .foregroundStyle(.white)
                .frame(width: 40, height: 40)
        }
    }
}

struct dumbEdit: View {
    var label: String
    var setFor: String
    var repetition: String?
    
    init(label: String, setFor: String, repetition: String? = nil) {
        self.label = label
        self.setFor = setFor
        self.repetition = repetition
    }
    var body: some View {
        
        
        ZStack{
            RoundedRectangle(cornerRadius: 15).foregroundStyle(.reds)
                .frame(width: 260, height: 175)
            
            VStack{
                Text(label).foregroundStyle(.white)
                    .font(Font.custom("RabbidHighwaySignII", size: 30, relativeTo: .title2))
                    .padding(.bottom, 1)
                
                
                VStack{
                    Text("Set to begin at " + setFor).foregroundStyle(.white)
                    
                        .font(Font.custom("BPReplay", size: 20, relativeTo: .headline))
                        .frame(width: 210)
                    
                        .padding(.bottom, 1)
                    if repetition != nil{
                        Text("\(repetition!)").foregroundStyle(.white)
                            .font(Font.custom("BPReplay", size: 20, relativeTo: .headline))
                            .frame(width: 210)
                        
                    }else{
                        Text("Does not repeat").foregroundStyle(.white)
                            .font(Font.custom("BPReplay", size: 20, relativeTo: .headline))
                            .frame(width: 210)
                        
                        
                    }
                }
            }
        }
    }
}
