import SwiftUI

struct GameView: View {
    var playerName: String
    var playerSide: String
    @Binding var showGame: Bool
    
    @State private var playerCard = ""
    @State private var opponentCard = ""
    @State private var playerScore = 0
    @State private var opponentScore = 0
    @State private var round = 0
    @State private var timer: Timer?
    @State private var countdownTimer: Timer?
    @State private var showSummary = false
    @State private var showCards = false
    @State private var countdown = 5
    @State private var isGameActive = false
    @Environment(\.colorScheme) var colorScheme
    
    // Using cards from the system
    let cards = [
        ("🂡", 1),  // Ace of Spades
        ("🂢", 2),  // 2 of Spades
        ("🂣", 3),  // 3 of Spades
        ("🂤", 4),  // 4 of Spades
        ("🂥", 5),  // 5 of Spades
        ("🂦", 6),  // 6 of Spades
        ("🂧", 7),  // 7 of Spades
        ("🂨", 8),  // 8 of Spades
        ("🂩", 9),  // 9 of Spades
        ("🂪", 10), // 10 of Spades
        ("🂫", 11), // Jack of Spades
        ("🂭", 12), // Queen of Spades
        ("🂮", 13)  // King of Spades
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack {
                    Text(playerName)
                    Spacer()
                    Text("PC")
                }
                .font(.headline)
                .padding()
                
                Text("Round: \(round) / 10")
                    .font(.title2)
                
                // Countdown timer
                if isGameActive {
                    Text("Next round in: \(countdown)")
                        .font(.title3)
                        .foregroundColor(.red)
                }
                
                HStack(spacing: 30) {
                    // Player's card - larger size
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white)
                            .frame(width: 180, height: 260)
                            .shadow(radius: 5)
                        
                        if showCards && !playerCard.isEmpty {
                            Text(playerCard)
                                .font(.system(size: 180))
                        } else {
                            Text("🂠")
                                .font(.system(size: 180))
                        }
                    }
                    
                    // Opponent's card - larger size
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white)
                            .frame(width: 180, height: 260)
                            .shadow(radius: 5)
                        
                        if showCards && !opponentCard.isEmpty {
                            Text(opponentCard)
                                .font(.system(size: 180))
                        } else {
                            Text("🂠")
                                .font(.system(size: 180))
                        }
                    }
                }
                
                Text("\(playerName): \(playerScore) | PC: \(opponentScore)")
                    .font(.headline)
                
                NavigationLink(
                    destination: SummaryView(playerName: playerName, playerScore: playerScore, opponentScore: opponentScore, showGame: $showGame),
                    isActive: $showSummary,
                    label: { EmptyView() }
                )
            }
            .padding()
            .navigationTitle("Game")
            #if os(iOS)
            .navigationBarBackButtonHidden(true)
            #endif
            .onAppear(perform: startGame)
            .onDisappear {
                stopGame()
            }
        }
    }
    
    func startGame() {
        round = 0
        playerScore = 0
        opponentScore = 0
        isGameActive = true
        startRound()
    }
    
    func startRound() {
        countdown = 5
        showCards = false
        
        // Countdown timer
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            countdown -= 1
            if countdown <= 0 {
                countdownTimer?.invalidate()
                playRound()
            }
        }
    }
    
    func playRound() {
        round += 1
        
        // Select random cards
        let playerCardData = cards.randomElement()!
        let opponentCardData = cards.randomElement()!
        
        playerCard = playerCardData.0
        opponentCard = opponentCardData.0
        showCards = true
        
        // Calculate score
        if playerCardData.1 > opponentCardData.1 {
            playerScore += 1
        } else if playerCardData.1 < opponentCardData.1 {
            opponentScore += 1
        }
        // In case of a tie - no points are added
        
        // Hide cards after 3 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showCards = false
            
            // End the game after 10 rounds
            if round >= 10 {
                isGameActive = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    showSummary = true
                }
            } else {
                // Start a new round
                startRound()
            }
        }
    }
    
    func stopGame() {
        timer?.invalidate()
        countdownTimer?.invalidate()
        isGameActive = false
    }
}
