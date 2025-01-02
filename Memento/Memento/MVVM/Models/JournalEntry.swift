//  Created by Julia Min on 10/26/24.



import SwiftUI
import UIKit
import PhotosUI
import SwiftData

struct JournalEntry: Identifiable {
    let id = UUID()
    var image: UIImage
    var caption: String
    var date: Date
    var allowedDate: Bool
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self.date)
    }
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: self.date)
    }
    var description: String?

}

/// This is my work in progress for making the data persistent for the photo journal.

/*
@Model
class journal: Identifiable {
    var id = UUID()
    var image: UIImage
    var caption: String
    var date: Date
    var allowedDate: Bool
    var formattedTime: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        return dateFormatter.string(from: self.date)
    }
    var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy"
        return dateFormatter.string(from: self.date)
    }
    
    init(id: UUID = UUID(), image: Data, caption: String, date: Date, allowedDate: Bool) {
        self.id = id
        self.image = image
        self.caption = caption
        self.date = date
        self.allowedDate = allowedDate
    }
}
    
    

*/
