//
//  VictoryView.swift
//  War Card Game
//
//  Created by Ian Gillette on 8/22/25.
//

import SwiftUI

struct GameEndView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack {
            Image("background-cloth")
                .resizable()
                .ignoresSafeArea(edges: .all)
            VStack {
                Spacer()
                VStack {
                    Text("Game Has Ended")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 20)
                    if gameManager.winner == "draw" {
                        Text("It was a DRAW!")
                    } else if gameManager.winner == "player" {
                        Text("The PLAYER won!")
                    } else if gameManager.winner == "computer" {
                        Text("The COMPUTER won!")
                    }
                }
                .font(.title)
                .foregroundColor(.white)
                Spacer()
                VStack {
                    Button(action: gameManager.restart, label: {
                        Image("reset-button")
                    })
                    Button(action: gameManager.reset, label: {
                        Image("home-button")
                    })
                }
                Spacer()
            }
        }
    }
}

#Preview {
    GameEndView()
        .environmentObject(GameManager())
}
