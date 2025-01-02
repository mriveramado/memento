//  Created by Matias Riveros-Amado on 12/28/24.


/// This is built from the "notifSaveLogic,swift" file. Everything is essentially the same, except the timer function. It is very strange because I used the base that I had for the notification persistent data model, but when I implement it, not only does it not work, it makes the notification store not work either.

/*
import Foundation
import SwiftUI
import Charts

class InteractionSaver: ObservableObject, Codable {
    @Published  var interactions: [interaction]
    
    var timer = Timer()
    var runCount = 0
    
    func method(label: String, id: String, interval: Double) {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
      //  interactionStore.shared.interactions.add(interaction(date: Date(), label: "label", completed: false, id: "hu"))

    }
    
    @objc func timerAction(){
      //  let repeater = interaction(date: Date(), label: label, completed: false, id: id)
        
      //  if Store.shared.notifs.containsID(id) && Store.shared.notifs.containsLabel(label){
          //  interactionStore.shared.interactions.add(repeater)
         //   interactionStore.shared.interactions.refresh()
     //   }else{
         //   timer.invalidate()
            print("siyuh")
        interactionStore.shared.interactions.add(interaction(date: Date(), label: "label", completed: false, id: "hu"))

      //  }
        }
    
    func updating(index: Int) -> Void  {
   //     print(interactions[index].completed)
        interactionStore.shared.interactions[index].completed.toggle()
        interactionStore.shared.interactions.refresh()
        print("done!!!")
       
    }
    
    func remove(at index: Int) {
            guard index >= 0 && index < interactions.count else { return }
            interactions.remove(at: index)
            // Save changes after removal
            interactionStore.shared.save(self, notifying: nil, userInfo: [:])
        }
    
    func refresh() {
            interactionStore.shared.save(self, notifying: nil, userInfo: [:])
        }
    
    enum CodingKeys: CodingKey {
        case interactions
    }

    init() {
        self.interactions = [interaction]()
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.interactions = try container.decode([interaction].self, forKey: .interactions)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.interactions, forKey: .interactions)
    }

    func add(_ alarm: interaction) {
        interactions.append(alarm)
        print("hiuh")
        // Handle your saving logic here if needed
    }

    var Count: Int {
        return interactions.count
    }

    func containsID(_ id: String) -> Bool {
        return interactions.filter{$0.id == id}.count > 0
    }
    func containsLabel(_ label: String) -> Bool {
        return interactions.filter{$0.label == label}.count > 0
    }
    
    subscript(index: Int) -> interaction {
        get {
                    return interactions[index]
                }
                set {
                    interactions[index] = newValue
                }
    }
}
*/
