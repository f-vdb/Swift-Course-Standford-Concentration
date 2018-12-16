//  ViewController.swift
//  Concentration Swift Course

import UIKit

class ViewController: UIViewController {
    private var game:Concentration!
    private var emojiChoices:String!
    private var themes:[String: ThemeData] = [ "sport":     ("⚽️🏀🎱⛷🧗🏻‍♂️🏌️‍♀️🏄‍♀️🚣🏼‍♀️🤺🏸🏓🛹🏂🤸‍♂️🎾", #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),
                                               "fruits":    ("🍏🍎🍐🍊🍋🍌🍉🍇🍓🍈🍒🍑🥭🍍🥝", #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)),
                                               "helloween": ("🦇👻🎃💣🔫🦉❄️🗡⚔️🤪😈👺🤡👹👽", #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))  ]
    
    typealias ThemeData = (emoji: String, cardColor: UIColor, backGroundColor: UIColor)
    private var theme:ThemeData!
    
    private var emoji = [Card: String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startGame()
    }
   
    func startGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count+1)/2)
        // cards.count + 1 because round up if there will be 3 cards ... but the last pair did not match
        // but the game has enough cards
        let randomIndex = themes.count.arc4random
        let key = Array(themes.keys)[randomIndex]
        theme = themes[key]!
        view.backgroundColor = theme!.backGroundColor
        flipCountLabel.textColor = theme!.cardColor
        newGameButton.setTitleColor(theme!.cardColor, for: UIControl.State.normal)
        emojiChoices = theme!.emoji
        updateViewFromModel()
    }
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBAction func touchNewGameButton(_ sender: UIButton) { startGame() }
    @IBAction func touchCard(_ sender: UIButton) {
        game.flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0) : theme!.cardColor
                // in xcode: type colorliteral than klick double on it
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
