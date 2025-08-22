//
//  GameView.swift
//  War Card Game
//
//  Created by Ian Gillette on 8/21/25.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack {
            Image("background-cloth")
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .center) {
                HStack {
                    Image("back")
                    Spacer()
                    Spacer()
                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text("\(gameManager.cpuScore)")
                            .font(.largeTitle)
                    }
                }
                .foregroundColor(.white)
                .padding(40)
                Spacer()
                HStack {
                    if (gameManager.isPlaying) {
                        Image(gameManager.cpuCard)
                        Spacer()
                        Spacer()
                        Image(gameManager.playerCard)
                    }
                }
                .padding(40)
                Spacer()
                HStack {
                    VStack {
                        Text("Player")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text("\(gameManager.playerScore)")
                            .font(.largeTitle)
                    }
                    Spacer()
                    Image("back")
                }
                .foregroundColor(.white)
                .padding(40)
            }
            .padding()
        }
        .onTapGesture(count: 1, perform: {
            if (!gameManager.isPlaying) {
                gameManager.isPlaying = true
            }
            gameManager.deal()
        })
    }
}

#Preview {
    GameView()
}
