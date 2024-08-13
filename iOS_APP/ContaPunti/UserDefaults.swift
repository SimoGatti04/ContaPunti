import Foundation

extension UserDefaults {
    private enum Keys {
        static let player1Score = "player1Score"
        static let player2Score = "player2Score"
        static let player1Name = "player1Name"
        static let player2Name = "player2Name"
    }
    
    var player1Score: Int {
        get { integer(forKey: Keys.player1Score) }
        set { set(newValue, forKey: Keys.player1Score) }
    }
    
    var player2Score: Int {
        get { integer(forKey: Keys.player2Score) }
        set { set(newValue, forKey: Keys.player2Score) }
    }
    
    var player1Name: String {
        get { string(forKey: Keys.player1Name) ?? "Player 1" }
        set { set(newValue, forKey: Keys.player1Name) }
    }
    
    var player2Name: String {
        get { string(forKey: Keys.player2Name) ?? "Player 2" }
        set { set(newValue, forKey: Keys.player2Name) }
    }
}
