//
//  Concentration.swift
//  Concentration
//
//  Created by Tomer Kobrinsky on 07/02/2019.
//  Copyright © 2019 Tomer Kobrinsky. All rights reserved.
//

import Foundation
class Concentration {
    
    var cards =  [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var score = 0
    var cardsThatHaveBeenSeen =  [Int: Bool]()
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,  matchIndex != index {
                //check if cards  matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    score += 2
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                } else {
                degradeScore(cardIndex: index)
                degradeScore(cardIndex: matchIndex)
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either  no cards or 2 cards face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    func degradeScore(cardIndex index: Int) {
        if let _ = cardsThatHaveBeenSeen[cards[index].identifier] {
            score -= 1
        } else {
        cardsThatHaveBeenSeen[cards[index].identifier] = true
        }
    }
    init(numberOfgPairOfCards: Int){
        for _ in 1...numberOfgPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    func shuffleCards() {
        cards.shuffle()
    }
}
