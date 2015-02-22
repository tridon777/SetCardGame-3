//
//  SetCardDeck.swift
//  SetCardGame
//
//  Created by Paul Searcy on 2/14/15.
//  Copyright (c) 2015 Paul Searcy. All rights reserved.
//

import Foundation

class SetCardDeck : Deck {
    
    override init() {
        super.init()
        // woot woot for x^4 time
        for shape in SetCard.valShape() {
            for valCol in SetCard.valColor() {
                for Fill in SetCard.valFill(){
                    for num in SetCard.ranInt(){
                        let card = SetCard(shape: shape,valCol:valCol,Fill: Fill,num:num)
                        addCard(card)
                    }
                    
                }
            }
        }
    }
}