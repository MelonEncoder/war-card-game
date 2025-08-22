//
//  GameViewModel.swift
//  War Card Game
//
//  Created by Ian Gillette on 8/21/25.
//

import SwiftUI

class GameManager: ObservableObject {
    @Published var showGame: Bool = false
    @Published var hasFlipped: Bool = false
    @Published var playerScore: Int = 0
    @Published var playerWarWins: Int = 0
    @Published var playerCard: Card!
    @Published var playerDeck: [Card] = []
    @Published var playerHand: [Card] = []
    @Published var cpuScore: Int = 0
    @Published var cpuWarWins: Int = 0
    @Published var cpuCard: Card!
    @Published var cpuDeck: [Card] = []
    @Published var cpuHand: [Card] = []
    @Published var cpuCaptureDeck: [Card] = []
    @Published var winner: String? = nil
    
    // Precondition of flip function is that both the player and cpu have cards
    func flip() {
        print("Total Cards in Play: ", playerHand.count + cpuHand.count)
        
        if playerHand.isEmpty {
            playerHand = shuffle(deck: &playerDeck)
        }
        if cpuHand.isEmpty {
            cpuHand = shuffle(deck: &cpuDeck)
        }
        
        playerCard = playerHand.remove(at: 0)
        cpuCard = cpuHand.remove(at: 0)

        if playerCard.value() > cpuCard.value() {
            playerScore += 1
            let num: Int = Int.random(in: 1...2)
            if num == 1 {
                playerDeck.append(playerCard)
                playerDeck.append(cpuCard)
            } else if num == 2 {
                playerDeck.append(cpuCard)
                playerDeck.append(playerCard)
            }
        } else if cpuCard.value() > playerCard.value() {
            cpuScore += 1
            let num: Int = Int.random(in: 1...2)
            if num == 1 {
                cpuDeck.append(playerCard)
                cpuDeck.append(cpuCard)
            } else if num == 2 {
                cpuDeck.append(cpuCard)
                cpuDeck.append(playerCard)
            }
        } else if playerCard.value() == cpuCard.value() { // WAR
            if playerDeck.isEmpty && cpuDeck.isEmpty {
                winner = "draw"
            } else if playerDeck.isEmpty {
                winner = "computer"
            } else if cpuDeck.isEmpty {
                winner = "player"
            } else {
                war()
            }
        }
        
        func war(playerTempDeck: [Card] = [], cpuTempDeck: [Card] = []) {
            print("WAR")
            
            var playerTD: [Card] = playerTempDeck
            var cpuTD: [Card] = cpuTempDeck
            
            for _ in 1...4 {
                if playerHand.isEmpty && !playerDeck.isEmpty {
                    playerHand = shuffle(deck: &playerDeck)
                }
                if cpuHand.isEmpty && !cpuDeck.isEmpty {
                    cpuHand = shuffle(deck: &cpuDeck)
                }
                if !playerHand.isEmpty {
                    playerTD.append(playerHand.remove(at: 0))
                }
                if !cpuHand.isEmpty {
                    cpuTD.append(cpuHand.remove(at: 0))
                }
            }
            
            if playerTD.last!.value() == cpuTD.last!.value() {
                war(playerTempDeck: playerTD, cpuTempDeck: cpuTD)
                return
            } else {
                var tempWinDeck: [Card] = []
                tempWinDeck.append(playerCard)
                tempWinDeck.append(cpuCard)
                if playerTD.last!.value() > cpuTD.last!.value() {
                    playerWarWins += 1
                    for card in playerTD {
                        tempWinDeck.append(card)
                    }
                    for card in cpuTD {
                        playerScore += 1
                        tempWinDeck.append(card)
                    }
                    let size: Int = tempWinDeck.count
                    for _ in 0..<size {
                        if let index = tempWinDeck.indices.randomElement() {
                            playerDeck.append(tempWinDeck.remove(at: index))
                        }
                    }
                    return
                } else if cpuTD.last!.value() > playerTD.last!.value() {
                    cpuWarWins += 1
                    for card in playerTD {
                        cpuScore += 1
                        tempWinDeck.append(card)
                    }
                    for card in cpuTD {
                        tempWinDeck.append(card)
                    }
                    let size: Int = tempWinDeck.count
                    for _ in 0..<size {
                        if let index = tempWinDeck.indices.randomElement() {
                            cpuDeck.append(tempWinDeck.remove(at: index))
                        }
                    }
                    return
                }
            }

        }
    }
    
    func shuffle(deck: inout [Card]) -> [Card] {
        var hand: [Card] = []
        for _ in 0..<deck.count {
            if let index = deck.indices.randomElement() {
                hand.append(deck.remove(at: index))
            }
        }
        return hand
    }
    
    func reset() {
        showGame = false
        hasFlipped = false
        playerScore = 0
        playerWarWins = 0
        playerCard = nil
        playerDeck = []
        cpuScore = 0
        cpuWarWins = 0
        cpuCard = nil
        cpuDeck = []
        winner = nil
    }
    
    func restart() {
        reset()
        showGame = true
        dealHands()
    }
    
    func checkWin() {
        if playerHand.isEmpty && playerDeck.isEmpty && cpuHand.isEmpty && cpuDeck.isEmpty {
            winner = "draw"
        } else if playerHand.isEmpty && playerDeck.isEmpty {
            winner = "computer"
        } else if cpuDeck.isEmpty && cpuHand.isEmpty {
            winner = "player"
        }
    }
    
    func dealHands() {
        let deck: [Card] = getFullDeck(shuffled: true)
        playerHand = []
        playerDeck = []
        cpuHand = []
        cpuDeck = []
        for index in 0...(deck.count - 1) {
            if index % 2 == 0 {
                playerHand.append(deck[index])
            } else {
                cpuHand.append(deck[index])
            }
        }
        print(playerDeck.count, cpuDeck.count)
    }
}
 
enum Rank: Int {
        case two = 2
        case three, four, five, six, seven, eight, nine, ten
        case jack, queen, king
        case ace = 14

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
        for rank in 2...14 {
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
