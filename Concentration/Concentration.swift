//
//  Concentration.swift
//  Concentration
//
//  Created by Tomer Kobrinsky on 07/02/2019.
//  Copyright © 2019 Tomer Kobrinsky. All rights reserved.
//

import Foundation
class Concentration {
    
    private(set) var cards =  [Card]()
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    private(set) var score = 0
    private var cardsThatHaveBeenSeen =  [Int: Bool]()
    private(set) var numberOfFlips = 0
    private var timeWhenGameStarted = Date.init()
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index): chosen index not in the cards")
        if !cards[index].isFaceUp {
            numberOfFlips += 1
        }
        if !cards[index].isMatched {
            if let IndexOfFacedUpCard = indexOfOneAndOnlyFaceUpCard,  IndexOfFacedUpCard != index {
                //check if cards  matched
                if cards[IndexOfFacedUpCard].identifier == cards[index].identifier {
                    score += Int(100 * calulateFactor())
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
                
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    private func calulateFactor() -> Double {
        let currentTime = Date.init()
        return 1 / currentTime.timeIntervalSince(timeWhenGameStarted)
        
    }
    
    private func degradeScore(cardIndex index: Int) ->  Bool{
        if cardsThatHaveBeenSeen[cards[index].identifier] != nil {
            score -= Int(2  * 1 / calulateFactor())
            return true
        } else {
            return false
        }
    }
    init(NumberOfButtons: Int){
        assert(NumberOfButtons > 0, "Concentration.init(at: \(NumberOfButtons): you must have at least 1 button")
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
    private func resetCards(numberOfgPairOfCards: Int){
        cards = []
        for _ in 1...numberOfgPairOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
    
    private func shuffleCards() {
        cards.shuffle()
    }
}
