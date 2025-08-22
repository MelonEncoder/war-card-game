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
                        HStack {
                            Text("score: \(gameManager.cpuScore)")
                                .font(.title)
                        }
                        HStack {
                            Text("cards: \(gameManager.cpuDeck.count)")
                                .font(.title)
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(40)
                Spacer()
                HStack {
                    if (gameManager.isPlaying) {
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
                        HStack {
                            Text("score: \(gameManager.playerScore)")
                                .font(.title)
                        }
                        HStack {
                            Text("cards: \(gameManager.playerDeck.count)")
                                .font(.title)
                        }
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
            if (!gameManager.isPlaying) {
                gameManager.isPlaying = true
            }
            gameManager.flip()
            gameManager.checkWin()
            print(gameManager.playerCard.getRank())
            print(gameManager.cpuCard.getRank())
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
