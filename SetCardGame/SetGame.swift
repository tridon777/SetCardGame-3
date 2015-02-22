//
//  SetGame.swift
//  SetCardGame
//
//  Created by Paul Searcy on 2/14/15.
//  Copyright (c) 2015 Paul Searcy. All rights reserved.
//

import Foundation
class SetGame{
    private let deck:SetCardDeck
    private let numCards : Int
    private var cardsinPlay : [SetCard] = []
    private var cardStack : [SetCard] = []
    
    init(numCards:Int, theDeck: SetCardDeck){
        self.numCards = numCards
        self.deck = theDeck
        for cardx in 1...numCards {
            cardsinPlay.append(self.deck.drawRandomCard()! as SetCard)
        }
    }
    
    func retCard(index: Int) -> SetCard{
        return cardsinPlay[index]
    }
    func appCard(holder: Int){
        
        cardStack.append(retCard(holder))
    }
    func clear (){
        
        cardStack = []
    }
    func shuffle(input: Int) -> SetCard{
         var shuffled = self.deck.drawRandomCard()! as SetCard
        cardsinPlay[input] = shuffled
        return shuffled
    }
    func reLast(){
        cardStack.removeLast()
    }
    func clearCardIn(){
        cardsinPlay = []
        
    }
    func mod(tCard : SetCard){
        cardsinPlay.append(tCard)
        
        
    }
    /* Divide up logic into specific functions. Very simple algorithm! Thought it was going to be alot harder, but I broke it down into methods which made it alot easier to see that it's just repetitive checking. */
    func checkStack() -> Bool{
        var card1 = cardStack[0]
        var card2 = cardStack[1]
        var card3 = cardStack[2]
        var test1 = numCheck(card1.num, C2: card2.num,C3: card3.num)
        var test2 = shapeCheck(card1.shape, C2: card2.shape, C3: card3.shape)
        var test3 = shapeCheck(card1.Fill, C2: card2.Fill, C3: card3.Fill)
        var test4 = colCheck(card1.valCol, C2: card2.valCol, C3: card3.valCol)
        if (test1 == true && test2 == true && test3 == true && test4 == true){
            return true
        }
        else{
            cardStack = []
            
            return false
        }
    }
    func numCheck(C1: String, C2: String, C3: String) -> Bool{
        if (C1 == C2 && C1 == C3){
            return true
        }
        else if (C1 != C2 && C1 != C3 && C2 != C3) {
            return true
        }
        else{
            return false
        }
    }
    func shapeCheck(C1: String, C2: String, C3: String) -> Bool{
        if (C1 == C2 && C1 == C3){
            return true
        }
        else if (C1 != C2 && C1 != C3 && C2 != C3) {
            return true
        }
        else{
            return false
        }
    }
    func shadCheck(C1: String, C2: String, C3: String) -> Bool{
        if (C1 == C2 && C1 == C3){
            return true
        }
        else if (C1 != C2 && C1 != C3 && C2 != C3) {
            return true
        }
        else{
            return false
        }
    }
    func colCheck(C1: String, C2: String, C3: String) -> Bool{
        if (C1 == C2 && C1 == C3){
            return true
        }
        else if (C1 != C2 && C1 != C3 && C2 != C3) {
            return true
        }
        else{
            return false
        }
    }
}