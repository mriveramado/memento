// Authored by George Zhou, 10/30/24 

import Foundation
import SwiftUI
import Combine

class ReallyCoolMath: ObservableObject {
    @Published var currentQuestion: String = ""
    @Published var answerChoices: [Int] = []
    @Published var correctAnswer: Int = 0
    @Published var timeRemaining: Int = 10
    @Published var score: Int = 0
    @Published var highScore: Int = 0
    @Published var gameOver: Bool = false
    

    
    private var timerCancellable: AnyCancellable?
    
    func startNewGame() {
        score = 0
        gameOver = false
        loadHighScore()
        generateQuestion()
        startTimer()
    }
    
    func generateQuestion() {
        guard !gameOver else { return } // Prevent generating a question if the game is over

        let number1 = Int.random(in: 1...45) // this may be 2 difficult lol
        let number2 = Int.random(in: 1...45)
        let operations = ["+", "-"]
        let operation = operations.randomElement()!
        
        switch operation {
        case "+":
            correctAnswer = number1 + number2
            currentQuestion = "\(number1) + \(number2)"
        case "-":
            correctAnswer = number1 - number2
            currentQuestion = "\(number1) - \(number2)"
            
            //removed multiplication primarily because it was too difficult
        //case "×":
          //  correctAnswer = number1 * number2
            //currentQuestion = "\(number1) × \(number2)"
        //case "÷":
         
         //   let divisor = number2 == 0 ? 1 : number2
           // let dividend = number1 * divisor
          //  correctAnswer = number1
            //currentQuestion = "\(dividend) ÷ \(divisor)"
        default:
            break
        }
        
        generateAnswerChoices()
        resetTimer()
    }
    
    func generateAnswerChoices() {
        var choices = [correctAnswer]
        while choices.count < 3 {
            let randomChoice = Int.random(in: correctAnswer - Int.random(in: 1...21)...correctAnswer + Int.random(in: 1...21)) // not that random but whatevs
            if randomChoice != correctAnswer && !choices.contains(randomChoice) {
                choices.append(randomChoice)
            }
        }
        answerChoices = choices.shuffled()
    }
    
    func selectAnswer(_ answer: Int) {
        if answer == correctAnswer {
            score += 1
            if score > highScore {
                highScore = score
                saveHighScore()
            }
            generateQuestion()
        } else {
            endGame()
        }
    }
    
    func startTimer() {
        timeRemaining = 10
        timerCancellable = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                self.timeTick()
            }
    }
    
    func resetTimer() {
        timerCancellable?.cancel()
        startTimer()
    }
    
    func timeTick() {
        if timeRemaining > 0 {
            timeRemaining -= 1
        }
        if timeRemaining <= 0 {
            timeRemaining = 0 // Clamp to 0 to prevent negative values
            endGame()
        }
    }
    
    func endGame() {
            gameOver = true
            timerCancellable?.cancel()
            timerCancellable = nil
            currentQuestion = "" // Clear the question when the game is over
            answerChoices = [] // Clear the answer choices
        }
    
    func loadHighScore() {
        highScore = UserDefaults.standard.integer(forKey: "HighScore")
    }
    
    func saveHighScore() {
        UserDefaults.standard.set(highScore, forKey: "HighScore")
    }
}
