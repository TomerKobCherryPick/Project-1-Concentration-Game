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
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard,  matchIndex != index {
                //check if cards  matched
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
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
