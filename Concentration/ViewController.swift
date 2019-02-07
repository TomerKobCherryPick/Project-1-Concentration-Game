//
//  ViewController.swift
//  Concentration
//
//  Created by Tomer Kobrinsky on 06/02/2019.
//  Copyright © 2019 Tomer Kobrinsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   lazy var game = Concentration(numberOfgPairOfCards: (cardButtons.count + 1) / 2)
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips:  \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card wasn't in CardButtons")
        }
    }
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if(card.isFaceUp){
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoises = ["🎃","👻","😎","😜"]
    var emoji = [Int:String]()
    
    func emoji(for card: Card) -> String  {
        if emoji[card.identifier] == nil, emojiChoises.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoises.count)))
                emoji[card.identifier] = emojiChoises.remove(at: randomIndex)
            }
        return emoji[card.identifier] ?? "?"
    }
}

