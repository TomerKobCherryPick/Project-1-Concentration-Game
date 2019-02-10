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
    
    let backgroundThemes = [#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                            #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),
                            #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),
                            #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),
                            #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),
                            #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
                            ]
    
    let cardThemes = [#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),
                      #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
                      #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1),
                      #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1),
                      #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
                      #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),
                      ]
    
    
    let EmojiTheme = [
        ["🎃","👻","💀","☠️","👺","😈", "🦇","🌚","🔥","🌪","🕷","🕸"],
        ["⚽️","🏀","🏈","⚾️","🥎","🎾", "🏐","🏉","🥏","🎱","🏓","🏏"],
        ["🚗","🚕","🚙","🚌","🚎","🏎", "🚓","🚑","🚒","🚐","🚚","🚛"],
        ["🍏","🍎","🍐","🍊","🍋","🍌", "🍉","🍇","🍓","🥥","🥝","🍒"],
        ["🥐","🥯","🥖","🍞","🥨","🥞", "🍟","🥪","🥙","🌮","🍚","🥧"],
        ["🐶","🐱","🐭","🐹","🐰","🦊", "🐻","🐼","🦊","🐸","🐔","🐧"]
    ]
    
    lazy var themeIndex = returnRandomIndex()
    lazy var emojiChoises = returnEmojiTheme(index: themeIndex)
    lazy var cardTheme = returnCardTheme(index: themeIndex)
    lazy var backgroundTheme = returnBackgroundTheme(index: themeIndex)
    
    var emoji = [Int:String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundTheme
        updateViewFromModel()
    }
    
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        scoreLabel.text = "Score: 0"
        flipCountLabel.text = "Flips: 0"
        generateRandomTheme()
        view.backgroundColor = backgroundTheme
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = cardTheme
        }
        game.resetGame(NumberOfButtons: cardButtons.count)
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
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
            flipCountLabel.text = "Flips: \(game.numberOfFlips)"
            if(card.isFaceUp){
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : cardTheme
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
    
    func generateRandomTheme() {
        themeIndex = returnRandomIndex()
        emojiChoises = EmojiTheme[themeIndex]
        cardTheme = cardThemes[themeIndex]
        backgroundTheme = backgroundThemes[themeIndex]
    }
    
    func returnEmojiTheme(index: Int) -> [String] {
        return EmojiTheme[index]
    }
    func returnRandomIndex() -> Int {
        return Int.random(in: 0..<EmojiTheme.count)
    }
    func returnCardTheme(index: Int) -> UIColor {
        return cardThemes[index]
    }
    func returnBackgroundTheme(index: Int) -> UIColor {
        return backgroundThemes[index]
    }
    
    
    
}

