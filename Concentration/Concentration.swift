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
    var numberOfFlips = 0
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let IndexOfFacedUpCard = indexOfOneAndOnlyFaceUpCard,  IndexOfFacedUpCard != index {
                //check if cards  matched
                if cards[IndexOfFacedUpCard].identifier == cards[index].identifier {
                    score += 2
                    cards[IndexOfFacedUpCard].isMatched = true
                    cards[index].isMatched = true
                } else {
                    if !degradeScore(cardIndex: index) {
                         cardsThatHaveBeenSeen[cards[index].identifier] = true
                    }
                    if !degradeScore(cardIndex: IndexOfFacedUpCard) {
                         cardsThatHaveBeenSeen[cards[IndexOfFacedUpCard].identifier] = true
                    }
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
    
    func degradeScore(cardIndex index: Int) ->  Bool{
        if cardsThatHaveBeenSeen[cards[index].identifier] != nil {
            score -= 1
            return true
        } else {
            return false
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
