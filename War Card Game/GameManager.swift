//
//  GameViewModel.swift
//  War Card Game
//
//  Created by Ian Gillette on 8/21/25.
//

import SwiftUI

class GameManager: ObservableObject {
    @Published var showGame: Bool = false
    @Published var isPlaying: Bool = false
    @Published var playerCard: Card!
    @Published var playerScore: Int = 0
    @Published var playerDeck: [Card] = []
    @Published var cpuCard: Card!
    @Published var cpuScore: Int = 0
    @Published var cpuDeck: [Card] = []
    @Published var winner: String = ""
    
    func flip() {
        let playerIndex: Int = Int.random(in: 0...playerDeck.count - 1)
        let cpuIndex: Int = Int.random(in: 0...cpuDeck.count - 1)
        playerCard = playerDeck[playerIndex]
        cpuCard = cpuDeck[cpuIndex]
        if playerCard.value() > cpuCard.value() {
            playerScore += 1
            playerDeck.append(cpuDeck.remove(at: cpuIndex))
        } else if cpuCard.value() > playerCard.value() {
            cpuScore += 1
            cpuDeck.append(playerDeck.remove(at: playerIndex))
        } else if playerCard.value() == cpuCard.value() {
            print("war")
        }
    }
    
    func checkWin() {
        if playerDeck.isEmpty {
            print("The COMPUTER has won!")
            winner = "computer"
        } else if cpuDeck.isEmpty {
            print("The PLAYER has won!")
            winner = "player"
        }
    }
    
    func dealHands() {
        let deck: [Card] = getFullDeck(shuffled: true)
        playerDeck = []
        cpuDeck = []
        for index in 0...(deck.count - 1) {
            if index % 2 == 0 {
                playerDeck.append(deck[index])
            } else {
                cpuDeck.append(deck[index])
            }
        }
        print(playerDeck.count, cpuDeck.count)
    }
}
 
enum Rank: Int {
        case ace = 1
        case two, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
            case .ace:
                return "ace"
            case .jack:
                return "jack"
            case .queen:
                return "queen"
            case .king:
                return "king"
            default:
                return String(self.rawValue)
        }
    }
}

enum Suit {
    case spades, hearts, diamonds, clubs
    
    func simpleDescription() -> String {
        switch self {
            case .spades:
                return "spades"
            case .hearts:
                return "hearts"
            case .diamonds:
                return "diamonds"
            case .clubs:
                return "clubs"
        }
    }
}

class Card {
    private var rank: Rank
    private var suit: Suit
    
    init(rank: Rank, suit: Suit) {
        self.rank = rank
        self.suit = suit
    }
    
    public func getRank() -> String {
        return self.rank.simpleDescription()
    }
    
    public func getSuit() -> String {
        return self.suit.simpleDescription()
    }
    
    public func value() -> Int {
        return self.rank.rawValue
    }
}

func getFullDeck(shuffled: Bool) -> [Card] {
    var deck: [Card] = []
    for suit in [Suit.spades, Suit.hearts, Suit.clubs, Suit.diamonds] {
        for rank in 1...13 {
            if let validRank = Rank(rawValue: rank) {
                deck.append(Card(rank: validRank, suit: suit))
            }
        }
    }
    
    if shuffled {
        var shuffledDeck: [Card] = []
        while !deck.isEmpty {
            if let randomIndex = deck.indices.randomElement() {
                shuffledDeck.append(deck.remove(at: randomIndex))
            }
        }
        return shuffledDeck
    }

    return deck
}
