//
//  ContentView.swift
//  War Card Game
//
//  Created by Ian Gillette on 7/21/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        if !gameManager.showGame && gameManager.winner == "" {
            HomeView()
        } else if gameManager.showGame && gameManager.winner == "" {
            GameView()
        } else if !gameManager.showGame && gameManager.winner != "" {
            VictoryView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GameManager())
}
