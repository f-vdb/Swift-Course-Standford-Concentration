//  Card.swift
//  Concentration Swift Course

import Foundation

// struct -> no inheritance
// struct -> value Type (it gets copied)
// class -> reference Type
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0

    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1 // in an static function the name Card.identifierFactory isn't needed
        return Card.identifierFactory
    }
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
