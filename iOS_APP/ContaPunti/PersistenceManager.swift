//
//  PersistenceManager.swift
//  ContaPunti
//
//  Created by Aurora Bellini on 29/07/24.
//

import Foundation

struct PlayerData: Codable {
    var player1Name: String
    var player2Name: String
    var player1Score: Int
    var player2Score: Int
}

class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let fileName = "playerData.json"
    
    private var fileURL: URL {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentDirectory.appendingPathComponent(fileName)
    }
    
    func saveData(_ data: PlayerData) {
        do {
            let jsonData = try JSONEncoder().encode(data)
            try jsonData.write(to: fileURL)
        } catch {
            print("Failed to save data: \(error.localizedDescription)")
        }
    }
    
    func loadData() -> PlayerData? {
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let data = try JSONDecoder().decode(PlayerData.self, from: jsonData)
            return data
        } catch {
            print("Failed to load data: \(error.localizedDescription)")
            return nil
        }
    }
}
