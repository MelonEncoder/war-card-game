//
//  HomeView.swift
//  War Card Game
//
//  Created by Ian Gillette on 8/21/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack {
            Image("background-plain")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                Spacer()
                Spacer()
                Image("logo")
                Spacer()
                Button(action: play, label: {
                    Image("play-button")
                })
                Spacer()
                Spacer()
            }
        }
    }
    func play() {
        gameManager.showGame = true
    }
}

#Preview {
    HomeView()
}
