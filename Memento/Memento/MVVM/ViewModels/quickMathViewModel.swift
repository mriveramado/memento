// Authored by George Zhou, 10/30/24

import SwiftUI

struct QuickMathGame: View {
    @StateObject var viewModel = ReallyCoolMath()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        
        VStack {
            
            
            Spacer()
            
            ZStack {
                if !viewModel.gameOver {
                    VStack {
                        HStack{
                            Spacer()
                            Button("Quit"){
                            dismiss()
                        }.font(Font.custom("RabbidHighwaySignII", size: 20))
                                .multilineTextAlignment(.trailing)
                                .padding()
                                .background(Color.red)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                .padding([.top, .trailing], 5)
                        }
                        
                        Spacer()
                            
                        
                        Text(viewModel.currentQuestion)
                            .font(Font.custom("RabbidHighwaySignII", size: 40, relativeTo: .largeTitle))
                            .padding()
                            .padding(.top, -20)
                        
                        HStack(spacing: 20) {
                            ForEach(viewModel.answerChoices, id: \.self) { choice in
                                Button(action: {
                                    viewModel.selectAnswer(choice)
                                }) {
                                    Text("\(choice)")
                                        .padding(.top, 10)
                                        .frame(width: 120, height: 80)
                                        .background(Color("purples"))
                                        .foregroundColor(.white)
                                        .font(Font.custom("RabbidHighwaySignII", size: 40, relativeTo: .largeTitle))
                                        .cornerRadius(10)
                                        .padding([.trailing, .leading], -8)
                                }
                            }
                        }
                        .padding()
                        
                        Text("Time Remaining: \(viewModel.timeRemaining)")
                            .font(Font.custom("RabbidHighwaySignII", size: 20, relativeTo: .headline))
                            .padding()
                        
                        ProgressView(value: Double(viewModel.timeRemaining), total: 10)
                            .padding()
                            .progressViewStyle(LinearProgressViewStyle(tint: Color("purples")))
                        
                        HStack {
                            Text("Score: \(viewModel.score)")
                                .font(Font.custom("BPreplay", size: 20, relativeTo: .subheadline))

                            Spacer()
                            Text("High Score: \(viewModel.highScore)")
                                .font(Font.custom("BPreplay", size: 20, relativeTo: .subheadline))

                        }
                        .padding()
                        Spacer()
                    }
                } else {
                    VStack {
                        Text("Game Over!")
                            .font(Font.custom("RabbidHighwaySignII", size: 45, relativeTo: .largeTitle))
                            .padding()
                        
                        // Display the current and high scores on the game-over screen
                        Text("Your Score: \(viewModel.score)")
                            .font(Font.custom("BPreplay", size: 25, relativeTo: .title))
                            .padding(.bottom, 5)
                        
                        Text("High Score: \(viewModel.highScore)")
                            .font(Font.custom("BPreplay", size: 25, relativeTo: .title))
                            .padding(.bottom, 20)
                        
                        Button("Play Again") {
                            viewModel.startNewGame()
                        }
                        .font(Font.custom("RabbidHighwaySignII", size: 25))
                        .padding()
                        .background(Color("purples"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.top, 10)
                        
                        Button("Quit"){
                            dismiss()
                        
                    }.font(Font.custom("RabbidHighwaySignII", size: 25))
                            .multilineTextAlignment(.trailing)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding(.top, 20)
                            .padding(.bottom, -20)
                    }
                    .padding()
                    .transition(.opacity)
                }
            }
            
            Spacer()
        }.navigationBarBackButtonHidden(true)
        .padding()
        .onAppear {
            viewModel.startNewGame()
        }
    }
}

#Preview{
    QuickMathGame()
}
