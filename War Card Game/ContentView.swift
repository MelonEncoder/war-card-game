//
//  ContentView.swift
//  War Card Game
//
//  Created by Ian Gillette on 7/21/25.
//

import SwiftUI

struct ContentView: View {
    @State private var playerCard: String = "back"
    @State private var cpuCard: String = "back"
    @State private var playerScore: Int = 0
    @State private var cpuScore: Int = 0
    
    var body: some View {
        ZStack {
            Image("background-cloth")
                .resizable()
                .ignoresSafeArea()
            VStack(alignment: .center) {
                Spacer()
                Image("logo")
                Spacer()
                HStack {
                    Spacer()
                    Image(playerCard)
                    Spacer()
                    Image(cpuCard)
                    Spacer()
                }
                Spacer()
                Button(action: deal, label: {
                    Image("button")
                })
                Spacer()
                HStack {
                    Spacer()
                    VStack {
                        Text("Player")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text("\(playerScore)")
                            .font(.largeTitle)
                    }
                    Spacer()
                    VStack {
                        Text("CPU")
                            .font(.headline)
                            .padding(.bottom, 10.0)
                        Text("\(cpuScore)")
                            .font(.largeTitle)
                    }
                    Spacer()
                }
                .foregroundColor(.white)
                Spacer()
            }
            .padding()
        }
    }
    
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



#Preview {
    ContentView()
}
