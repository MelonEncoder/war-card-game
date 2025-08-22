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
        if !gameManager.showGame && gameManager.winner == nil {
            HomeView()
        } else if gameManager.showGame && gameManager.winner == nil {
            GameView()
        } else if gameManager.winner != nil {
            GameEndView()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(GameManager())
}
