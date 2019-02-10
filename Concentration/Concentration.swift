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
    var timeWhenGameStarted = Date.init()
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            numberOfFlips += 1
            if let IndexOfFacedUpCard = indexOfOneAndOnlyFaceUpCard,  IndexOfFacedUpCard != index {
                //check if cards  matched
                if cards[IndexOfFacedUpCard].identifier == cards[index].identifier {
                    score += Int(10 * calulateFactor())
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
    func calulateFactor() -> Double {
        let currentTime = Date.init()
        return 1 / currentTime.timeIntervalSince(timeWhenGameStarted)
        
    }
    
    func degradeScore(cardIndex index: Int) ->  Bool{
        if cardsThatHaveBeenSeen[cards[index].identifier] != nil {
            score -= Int(2  * 1 / calulateFactor())
            return true
        } else {
            return false
        }
    }
    init(NumberOfButtons: Int){
        let numberOfgPairOfCards = (NumberOfButtons + 1) / 2
        resetCards(numberOfgPairOfCards: numberOfgPairOfCards)
    }
    
    func resetGame(NumberOfButtons: Int){
        let numberOfgPairOfCards = (NumberOfButtons + 1) / 2
        resetCards(numberOfgPairOfCards: numberOfgPairOfCards)
        indexOfOneAndOnlyFaceUpCard = nil
        score = 0
        cardsThatHaveBeenSeen =  [:]
        numberOfFlips = 0
        timeWhenGameStarted = Date.init()
        
    }
    func resetCards(numberOfgPairOfCards: Int){
        cards = []
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
