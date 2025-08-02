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
            
            Button("Back to Main Menu") {
                // חזרה למסך הראשי עם איפוס מלא
                backToMainMenu()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
        .navigationTitle("Game Over")
        #if os(iOS)
        .navigationBarBackButtonHidden(true)
        #endif
    }
    
    func finalResult() -> String {
        if playerScore > opponentScore {
            return "🎉 \(playerName) Wins! 🎉"
        } else if playerScore < opponentScore {
            return "🤖 PC Wins! 🤖"
        } else {
            // במקרה של תיקו - הבית מנצח
            return "🤖 PC Wins! 🤖"
        }
    }
    
    func backToMainMenu() {
        // איפוס המשתנה שמתחיל את המשחק
        showGame = false
        
        // חזרה למסך הראשי
        presentationMode.wrappedValue.dismiss()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
