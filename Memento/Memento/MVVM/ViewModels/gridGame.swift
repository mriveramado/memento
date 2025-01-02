// Authored by George Zhou, 10/30/24

import SwiftUI


class GameViewModel: ObservableObject {
    @Published var sequence: [Int] = []
    @Published var userSequence: [Int] = []
    @Published var currentStep: Int = 0
    @Published var showSequence: Bool = false
    @Published var highlightedIndex: Int? = nil
    @Published var gameOver: Bool = false
    @Published var success: Bool = false
    @Published var clickedIndices: [Int] = []
    @Published var dontTouch: Bool = true


    let totalBoxes = 16
    var sequenceLength = 1 // start with a sequence 1

    func startGame() {
        sequenceLength = 1
        startLevel()
    }

    func startLevel() {
        dontTouch = false
        sequence = (0..<totalBoxes).shuffled().prefix(sequenceLength).map { $0 }
        userSequence = []
        currentStep = 0
        gameOver = false
        success = false
        clickedIndices = []
        playSequence()
    }

    func playSequence() {
        showSequence = true
        currentStep = 0
        highlightNext()
    }

    func highlightNext() {
        if currentStep < sequence.count {
            highlightedIndex = sequence[currentStep]
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.highlightedIndex = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.currentStep += 1
                    self.highlightNext()
                }
            }
        } else {
            showSequence = false
        }
    }

    func selectBox(at index: Int) {
        guard !showSequence && !gameOver else { return }
        userSequence.append(index)
        clickedIndices.append(index)
        if sequence[userSequence.count - 1] != index {
            gameOver = true
            success = false
        } else if userSequence.count == sequence.count {
            if sequenceLength == totalBoxes {
                gameOver = true
                success = true
            } else {
                sequenceLength += 1
                dontTouch = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.dontTouch = false
                    self.startLevel()
                }
            }
        }
    }
}

struct GridGame: View {
    
    @State private var isButtonVisible = true
    @Environment(\.presentationMode) var presentationMode

    @StateObject var viewModel = GameViewModel()
    let gridSize = 4
    let totalBoxes = 16

    var body: some View {
        @State var isGameOver = viewModel.gameOver

        let columns = Array(repeating: GridItem(.flexible()), count: gridSize)

        VStack {
            HStack{
                Spacer()
                Button("Quit"){
                presentationMode.wrappedValue.dismiss()
                
            }.font(Font.custom("RabbidHighwaySignII", size: 20))
                    .multilineTextAlignment(.trailing)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding()
            }

            Text("Level \(viewModel.sequenceLength)")
                .font(Font.custom("RabbidHighwaySignII", size: 30))
                .padding(.bottom, 10)
                

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(0..<totalBoxes, id: \.self) { index in
                    BoxView(
                        index: index,
                        isHighlighted: viewModel.highlightedIndex == index,
                        isClicked: viewModel.clickedIndices.contains(index)
                    )
                    .onTapGesture {
                        viewModel.selectBox(at: index)
                    }
                    .animation(.easeInOut(duration: 0.2), value: viewModel.highlightedIndex)
                }
            }
            .disabled(isButtonVisible || viewModel.dontTouch)
            .padding()
            

            if viewModel.gameOver {
                Text(viewModel.success ? "Congratulations! You completed all levels!" : "Game Over! You reached level \(viewModel.sequenceLength)")
                    .font(Font.custom("BPreplay", size: 25, relativeTo: .title))
                    .multilineTextAlignment(.center)
                    .padding()
                    .padding(.top, -10)
                Button(action: {
                    isButtonVisible = false
                    viewModel.startGame()
                }) {
                    Text("Restart Game")
                        .font(Font.custom("RabbidHighwaySignII", size: 20))
                        .padding()
                        .background(Color("purples"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.top, -17)
                }

                .padding()
            } else if !viewModel.showSequence {
                if !isButtonVisible {
                    Text("Your Turn")
                        .font(Font.custom("BPreplay", size: 30))
                        .padding()
                }else{
                    Text("Your Turn")
                        .font(Font.custom("BPreplay", size: 30))
                        .padding()
                        .foregroundStyle(Color("Background"))
                }
            } else {
                Text("Watch the sequence")
                    .font(Font.custom("BPreplay", size: 30))
                    .padding()
            }
        
        if isButtonVisible {
                        Button(action: {
                            isButtonVisible = false
                            viewModel.startGame()
                        }) {
                            Text("Start Game")
                                .font(Font.custom("RabbidHighwaySignII", size: 20))
                                .padding()
                                .background(Color("purples"))
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
        }else{
            if !isGameOver {
                Button(action: {
                    isButtonVisible = false
                    viewModel.startGame()
                }) {
                    Text("Start Game")
                        .font(Font.custom("RabbidHighwaySignII", size: 20))
                        .padding()
                        .background(Color("Background"))
                        .foregroundColor(Color("Background"))
                        .cornerRadius(8)
                }.disabled(true)
            } else{
                EmptyView()
            }
        }
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Background"))
            .edgesIgnoringSafeArea(.all)
            .navigationBarBackButtonHidden(true)
        
    }
}

struct BoxView: View {
    let index: Int
    let isHighlighted: Bool
    let isClicked: Bool

    var body: some View {
        let baseColor: Color = .white
        let highlightColor: Color = isHighlighted ? .yellow : (isClicked ? .red : baseColor)
        let outlineColor: Color = .black.opacity(0.2) // outline color for visibility

        Rectangle()
            .foregroundColor(highlightColor)
            .cornerRadius(10) // rounded corners
            .overlay(
                Text("\(index + 1)")
                    .foregroundColor(.black)
                    .font(.headline)
                    .shadow(color: .white, radius: 1, x: 0, y: 0)
            )
            .frame(height: 70)
            .scaleEffect(isClicked ? 0.95 : 1.0) // press effect
            .shadow(color: isHighlighted ? .yellow.opacity(0.5) : .clear, radius: 5, x: 0, y: 0) // 3D effect for highlighted box
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(outlineColor, lineWidth: 1) // outline for better visibility
            )
            .animation(.easeInOut(duration: 0.1), value: isClicked) // Smooth operator
    }

}

#Preview{
    GridGame()
}
