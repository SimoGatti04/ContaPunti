import SwiftUI

extension Color {
    static let rosa = Color(red:0.96, green: 0.765, blue:0.796)
    static let azzurro = Color(red:0.784, green: 0.898, blue:0.96)
}

struct ContentView: View {
    @State private var player1Name: String = "Player 1"
    @State private var player2Name: String = "Player 2"
    @State private var player1Score: Int = 0
    @State private var player2Score: Int = 0
    
    init() {
        if let data = PersistenceManager.shared.loadData() {
            _player1Name = State(initialValue: data.player1Name)
            _player2Name = State(initialValue: data.player2Name)
            _player1Score = State(initialValue: data.player1Score)
            _player2Score = State(initialValue: data.player2Score)
        }
    }
    
    var body: some View {
        VStack (spacing: 0){
            PlayerOneView(playerName: $player1Name, playerScore: $player1Score)
            ZStack{
                LinearGradient(gradient: Gradient(colors: [Color.rosa, Color.azzurro]), startPoint: .top, endPoint: .bottom)
                            .edgesIgnoringSafeArea(.all)
                            .opacity(1)
                HStack {
                    Spacer()
                    ResetButton(action: resetScores)
                    Spacer()
                }
                .padding()

            }
            PlayerTwoView(playerName: $player2Name, playerScore: $player2Score)
        }
        .onChange(of: player1Name) { _ in saveData() }
        .onChange(of: player2Name) { _ in saveData() }
        .onChange(of: player1Score) { _ in saveData() }
        .onChange(of: player2Score) { _ in saveData() }
    }
    
    private func saveData() {
        let data = PlayerData(player1Name: player1Name, player2Name: player2Name, player1Score: player1Score, player2Score: player2Score)
        PersistenceManager.shared.saveData(data)
    }
    
    private func resetScores() {
        player1Score = 0
        player2Score = 0
    }
}

struct PlayerOneView: View {
    @Binding var playerName: String
    @Binding var playerScore: Int
    
    var body: some View {
        VStack {
            TextField("Player Name", text: $playerName)
                .font(.system(size: 30) .bold().italic())
                .foregroundColor(.black)
                .padding()
                .multilineTextAlignment(.center)
            Spacer()
    
            Text("\(playerScore)")
                .font(.system(size: 250))
                .foregroundColor(.black)
                .frame(height: 200)
            
            Spacer(minLength: 30)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.rosa)
        .onTapGesture {
            playerScore += 1
        }
        .gesture(
            DragGesture(minimumDistance: 50)
                .onEnded { value in
                    if value.translation.width < 0 {
                        playerScore = max(playerScore - 1, 0)
                    }
                }
        )
    }
}

struct PlayerTwoView: View {
    @Binding var playerName: String
    @Binding var playerScore: Int
    
    var body: some View {
        VStack {
            TextField("Player Name", text: $playerName)
                .font(.system(size: 30) .bold().italic())
                .foregroundColor(.black)
                .padding()
                .multilineTextAlignment(.center)
            Spacer()
    
            Text("\(playerScore)")
                .font(.system(size: 250))
                .foregroundColor(.black)
                .frame(height: 200)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.azzurro)
        .onTapGesture {
            playerScore += 1
        }
        .gesture(
            DragGesture(minimumDistance: 50)
                .onEnded { value in
                    if value.translation.width < 0 {
                        playerScore = max(playerScore - 1, 0)
                    }
                }
        )
    }
}

struct ResetButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "arrow.clockwise.circle.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.black)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
