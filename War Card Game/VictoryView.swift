//
//  VictoryView.swift
//  War Card Game
//
//  Created by Ian Gillette on 8/22/25.
//

import SwiftUI

struct VictoryView: View {
    @EnvironmentObject var gameManager: GameManager
    
    var body: some View {
        ZStack {
            Image("background-cloth")
                .resizable()
                .ignoresSafeArea(edges: .all)
            VStack {
                Text("VICTORY!!!")
            }
        }
    }
}

#Preview {
    VictoryView()
        .environmentObject(GameManager())
}
