import SwiftUI

struct SummaryView: View {
    var playerName: String
    var playerScore: Int
    var opponentScore: Int
    @Binding var showGame: Bool
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 30) {
            Text(finalResult())
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            
            Text("Final Score:")
                .font(.title2)
            
            Text("\(playerName): \(playerScore)")
                .font(.title3)
            
            Text("PC: \(opponentScore)")
                .font(.title3)
        }
        .padding()
        .navigationTitle("Game Over")
        #if os(iOS)
        .navigationBarBackButtonHidden(true)
        #endif
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                backToMainMenu()
            }
        }
    }
    
    func finalResult() -> String {
        if playerScore > opponentScore {
            return "🎉 \(playerName) Wins! 🎉"
        } else if playerScore < opponentScore {
            return "🤖 PC Wins! 🤖"
        } else {
            // In case of a tie - the house wins
            return "🤖 PC Wins! 🤖"
        }
    }
    
    func backToMainMenu() {
        // Reset the variable that starts the game
        showGame = false
        
        // Go back to the main screen
        presentationMode.wrappedValue.dismiss()
    }
}
