//  Card.swift
//  Concentration Swift Course

import Foundation

struct Card: Hashable {
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1 // in an static function the name Card.identifierFactory isn't needed
        return Card.identifierFactory
    }
    
    var hashValue: Int { return identifier}
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
