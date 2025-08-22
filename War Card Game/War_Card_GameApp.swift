//
//  War_Card_GameApp.swift
//  War Card Game
//
//  Created by Ian Gillette on 7/21/25.
//

import SwiftUI

@main
struct War_Card_GameApp: App {
    @StateObject private var gameManager: GameManager = GameManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(gameManager)
        }
    }
}
