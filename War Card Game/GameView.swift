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
                    CardStackView()
                    Spacer()
                    Spacer()
                    
                    VStack {
                        Text("CPU")
                            .font(.largeTitle)
                            .padding(.bottom, 10.0)
                        VStack {
                            Text("score: \(gameManager.cpuScore)")
                            Text("war wins: \(gameManager.cpuWarWins)")
                            Text("cards: \(gameManager.cpuDeck.count + gameManager.cpuHand.count)")
                        }
                        .font(.title)
                    }
                }
                .foregroundColor(.white)
                .padding(40)
                Spacer()
                HStack {
                    if (gameManager.hasFlipped) {
                        Image(gameManager.cpuCard.getRank())
                        Spacer()
                        Spacer()
                        Image(gameManager.playerCard.getRank())
                    }
                }
                .padding(40)
                Spacer()
                HStack {
                    VStack {
                        Text("Player")
                            .font(.largeTitle)
                            .padding(.bottom, 10.0)
                        VStack {
                            Text("score: \(gameManager.playerScore)")
                            Text("war wins: \(gameManager.playerWarWins)")
                            Text("cards: \(gameManager.playerDeck.count + gameManager.playerHand.count)")
                        }
                        .font(.title)
                    }
                    Spacer()
                    CardStackView()
                }
                .foregroundColor(.white)
                .padding(40)
            }
            .padding()
        }
        .onTapGesture(count: 1, perform: {
            gameManager.flip()
            if (!gameManager.hasFlipped) {
                gameManager.hasFlipped = true
            }
            gameManager.checkWin()
        })
    }
}

struct CardStackView: View {
    var body: some View {
        ZStack {
            Image("back")
            Image("back")
                .padding(.bottom, 5)
            Image("back")
                .padding(.bottom, 10)
            Image("back")
                .padding(.bottom, 15)
        }
    }
}

#Preview {
    GameView()
        .environmentObject(GameManager())
}
