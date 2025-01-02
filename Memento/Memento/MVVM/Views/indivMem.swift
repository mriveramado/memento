//  Created by Julia Min on 10/26/24.
// Edited and formatted by Matias Riveros-Amado


import SwiftUI

struct indivMem: View {
    
    var image: UIImage
    var caption: String
    var allowedDate: Bool
    var formattedDate: String
    var size: CGFloat?
    var font: CGFloat
    var smallFont: CGFloat

    var body: some View {
        VStack{
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size, height: size)
                .clipped()
                .cornerRadius(10)
            
                if caption.isEmpty{
                    if allowedDate{
                        Text(formattedDate)
                            .font(Font.custom("BPReplay", size: font, relativeTo: .headline))
                            .padding(.top, font)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 250, maxHeight: 40)
                            .foregroundColor(.blacks)
                        Text("")
                            .font(Font.custom("BPReplay", size: smallFont, relativeTo: .subheadline))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 250, maxHeight: 40)
                            .foregroundColor(.blacks)
                            .padding(.top, smallFont)
                        
                    }else{
                        Text("")
                            .font(Font.custom("BPReplay", size: font, relativeTo: .headline))
                            .padding(.top, font)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 250, maxHeight: 40)
                            .foregroundColor(.blacks)
                        Text("")
                            .font(Font.custom("BPReplay", size: smallFont, relativeTo: .subheadline))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 250, maxHeight: 40)
                            .foregroundColor(.blacks)
                            .padding(.top, smallFont)
                        
                    }
                    
                }else{
                    
                    Text(caption)
                        .font(Font.custom("BPReplay", size: font, relativeTo: .headline))
                        .padding(.top, font)
                        .lineLimit(nil)
                    // .fixedSize(horizontal: false, vertical: true)
                        .frame(maxWidth: size, maxHeight: 30)
                        .foregroundColor(.blacks)
                    if allowedDate{
                        Text(formattedDate)
                            .font(Font.custom("BPReplay", size: smallFont, relativeTo: .subheadline))
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 250, maxHeight: 40)
                            .foregroundColor(.blacks)
                            .padding(.top, smallFont)
                        
                    } else{
                        Text("")
                            .font(Font.custom("BPReplay", size: smallFont, relativeTo: .headline))
                            .padding(.top, 25)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: 250, maxHeight: 40)
                            .foregroundColor(.blacks)
                            .padding(.top, smallFont)
                        
                    }
                    
                }
            
        }
    }
}

    

/*
#Preview {
    indivMem()
}
*/
