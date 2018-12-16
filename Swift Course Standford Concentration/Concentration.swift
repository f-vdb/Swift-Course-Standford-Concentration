//
//  Concentration.swift
//  Concentration Swift Course
//
//  Created by Frank on 02.09.18.
//  Copyright © 2018 Frank. All rights reserved.
//

// Test
import Foundation

// model
struct Concentration {
    private(set) var cards = [Card]()
    var flipCount = 0
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            // Second version with closure and filter
            // let faceUpCardIndices = cards.indices.filter { cards[$0].isFaceUp }  // now tidy up with the extension for collection
            // return faceUpCardIndices.count == 1 ? faceUpCardIndices.first : nil
            // now with extension and closure
            
            // Third version with extension Collection
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
            // let ch = "hello".oneAndOnly  // nil
            // let h = "h".oneAndOnly // h

// First version without closure
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFaceUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        return nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card] // need two cards in a memory and this syntax is shoorte then twice card.append(card)
        }
        cards.shuffle()
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at_: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
