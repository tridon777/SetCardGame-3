//
//  Deck.swift
//  SetCardGame
//
//  Created by Paul Searcy on 2/14/15.
//  Copyright (c) 2015 Paul Searcy. All rights reserved.
//

import Foundation

class Deck {
    
     var cards : [Card] = []
    
    func addCard(card : Card, atTop: Bool) {
        if (atTop == true) {
            cards.insert(card, atIndex: 0)
        } else {
            cards.append(card)
        }
    }
    
    func addCard(card: Card) {
        addCard(card, atTop: false)
    }
    
    func drawRandomCard() -> Card? {
        var result: Card?
        if (cards.count > 0) {
            // The commented line below seems to make sense BUT can crash on iPhone 5
            // and other "older" architectures.  Why?  Because
            // arc4random() returns a UInt32.  The maximum value of
            // UInt32 is 4294967295.  On an iPhone 5 (and some others), the
            // max value of Int is 2147483647, so when arc4random() yields
            // a value bigger than max Int value, the conversion to Int
            // crashes (with a very-not-helpful message in XCode).
            // It doesn't crash on iPhone 6 and other newer devices because
            // the max value of Int on newer devices is much larger.
            //
            // Discussed at: http://stackoverflow.com/questions/24087518/crash-when-casting-the-result-of-arc4random-to-int
            //
            //let index = Int(arc4random()) % cards.count
            let index = Int(arc4random_uniform((UInt32(cards.count))))
            result = cards[index]
            cards.removeAtIndex(index)
        }
        return result
    }
}