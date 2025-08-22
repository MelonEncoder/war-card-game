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
        if (gameManager.showGame) {
            GameView()
        } else {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
