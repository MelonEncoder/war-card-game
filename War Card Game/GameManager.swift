//
//  GameViewModel.swift
//  War Card Game
//
//  Created by Ian Gillette on 8/21/25.
//

import SwiftUI

class GameManager: ObservableObject {
    @Published var showGame: Bool = false
    @Published var isPlaying: Bool = false
    @Published var playerCard: String = "back"
    @Published var cpuCard: String = "back"
    @Published var playerScore: Int = 0
    @Published var cpuScore: Int = 0
    
    func deal() {
        let player = Int.random(in: 2...14)
        playerCard = "card\(player)"
        let cpu = Int.random(in: 2...14)
        cpuCard = "card\(cpu)"
        if player > cpu {
            playerScore += 1
        } else if cpu > player {
            cpuScore += 1
        } else if player == cpu {
            print("war")
        }
    }
}
