//
//  ViewController.swift
//  Concentration
//
//  Created by Tomer Kobrinsky on 06/02/2019.
//  Copyright © 2019 Tomer Kobrinsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(NumberOfButtons: cardButtons.count)
    var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips:  \(flipCount)"
        }
    }
    
    let themes = [
        ["🎃","👻","💀","☠️","👺","😈", "🦇","🌚","🔥","🌪","🕷","🕸"],
        ["⚽️","🏀","🏈","⚾️","🥎","🎾", "🏐","🏉","🥏","🎱","🏓","🏏"],
        ["🚗","🚕","🚙","🚌","🚎","🏎", "🚓","🚑","🚒","🚐","🚚","🚛"],
        ["🍏","🍎","🍐","🍊","🍋","🍌", "🍉","🍇","🍓","🥥","🥝","🍒"],
        ["🥐","🥯","🥖","🍞","🥨","🥞", "🍟","🥪","🥙","🌮","🍚","🥧"],
        ["🐶","🐱","🐭","🐹","🐰","🦊", "🐻","🐼","🦊","🐸","🐔","🐧"]
    ]
    lazy var emojiChoises = emojiChoisesReset()
    var emoji = [Int:String]()
    
    
    @IBAction func touchNewGameButton(_ sender: UIButton) {
            flipCount = 0
            scoreLabel.text = "Score: 0"
            emojiChoises = emojiChoisesReset()
            for index in cardButtons.indices {
                let button = cardButtons[index]
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                
        }
         game.resetGame(NumberOfButtons: cardButtons.count)
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
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
            scoreLabel.text = "Score: \(game.score)"
            if(card.isFaceUp){
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    func emoji(for card: Card) -> String  {
        if emoji[card.identifier] == nil, emojiChoises.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoises.count)))
            emoji[card.identifier] = emojiChoises.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func emojiChoisesReset() -> [String] {
        return themes[Int.random(in: 0..<themes.count)]
    }
    
    
}

