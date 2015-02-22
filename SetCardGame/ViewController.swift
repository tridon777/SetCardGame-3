//
//  ViewController.swift
//  SetCardGame
//
//  Created by Paul Searcy on 2/14/15.
//  Copyright (c) 2015 Paul Searcy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    var deck : SetCardDeck!
    var game : SetGame!
    var turnN:Int = 0
    var scoreN:Int = 0
    var selector:Int = 0
    var buttonholder: [Int] = []
    var shapeDec: [String] = []
    var colorDec: [String] = []
    var shadeDec: [String] = []
    var numDec: [String] = []
    
    /* This handy little thing is so that you can't rotate the screen!*/
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Portrait.rawValue)
   }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBOutlet var setButtons: [UIButton]!
    
    
    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var output: UILabel!
    @IBOutlet var score: UILabel!
    @IBOutlet var turn: UILabel!
    
    /* Created 2 update GUI with polymorphism for the reset button and for chaning the titles of the buttons if  you get a correct combination*/
    func updateGUI(input: Int){
        
        //var heartsmil = "\u{2764}"
        //var heart = NSMutableAttributedString(string: heartsmil)
        var newCard = game.shuffle(input)
        setButtons[input].setAttributedTitle(newCard.contents, forState: UIControlState.Normal)
        setButtons[input].backgroundColor = UIColor.whiteColor()
        setButtons[input].enabled = true
    }
    func updateGUI(check: Bool){
        if check == true {
            for location in 0..<setButtons.count{
                var card = game.retCard(location)
                var button = setButtons[location]
                button.setAttributedTitle(card.contents, forState: UIControlState.Normal)
                button.backgroundColor = UIColor.whiteColor()
                button.enabled = true
            
            }
        }
        else if check == false{
            for location in 0..<setButtons.count{
                var card = game.retCard(location)
                var button = setButtons[location]
                button.setAttributedTitle(card.contents, forState: UIControlState.Normal)
                if (button.backgroundColor != UIColor.yellowColor()){
                    button.enabled = true
                }
                else{
                    button.enabled = false
                }
            }
        }
    }
    
   // Basic on click action
    @IBAction func GenericCard(sender: UIButton) {
        var buttonIndex : Int = find(setButtons, sender)!
        buttonholder.append(buttonIndex)
        game.appCard(buttonIndex)
        //updateGUI(buttonIndex) // Was for testing purposes
        // String shenanigans
        turnN += 1
        turn.text = "Turn: " + String(turnN)
        var holderC = " + "
        var plusN = NSMutableAttributedString(string: holderC, attributes: [NSFontAttributeName:UIFont(name: "Arial", size: 18.0)!])
        var copy = NSMutableAttributedString(attributedString: output.attributedText!)
        copy.appendAttributedString(sender.currentAttributedTitle!)
        copy.appendAttributedString(plusN)
        output.attributedText = copy
        sender.enabled = false
        /*  Was trying to make it so you could deselect buttons if you made a mistake.
            I was partially done with it when I realized I was overreaching and it was taking too long for what it was worth. Learned alot about NSRange and quirky string manipulation. Since were dealing with attributed strings which are a beast of their own. I took what I learned though and applied it to history label taking out the "+" */
        //if (sender.backgroundColor == UIColor.yellowColor()){
            //sender.backgroundColor = UIColor.whiteColor()
        
            //var x = sender.currentAttributedTitle?.length
            //var y = output.attributedText.length
            //var alpha = x! + 1;
            //var z = y - x! - 1;
            //var range = NSMakeRange(z,alpha);
            //output.attributedText = output.attributedText.attributedSubstringFromRange(range)
           // --selector
        //}
        /* The control structure where I call the logic for the game and determine what to do. Lots of checks and string modification along. Lots of logic errors I had to work through here.  */
        if selector == 2 {
            for x in 0..<setButtons.count{
                setButtons[x].backgroundColor = UIColor.whiteColor()
                setButtons[x].enabled = true
            }
            history.attributedText = output.attributedText
            var range = NSMakeRange(0,history.attributedText.length-2)
            history.attributedText = history.attributedText.attributedSubstringFromRange(range)
            sender.backgroundColor = UIColor.yellowColor()
            output.attributedText = sender.currentAttributedTitle
            copy = NSMutableAttributedString(attributedString: output.attributedText!)
            copy.appendAttributedString(plusN)
            output.attributedText = copy
            sender.enabled = false
            /* Created a stack of three cards and then parse them through the game logic here and spit out the outcome.  */
            if (game.checkStack()){
                scoreN += 2
                score.text = "Score: " + String(scoreN)
                output.text = ""
                for x in buttonholder{
                        updateGUI(x)
                }
                buttonholder = []
                game.clear()
                selector = 0
            }
            else{
                score.text = "Score: " + String(--scoreN)
                game.clear()
                buttonholder = []
                game.appCard(buttonIndex)
                buttonholder.append(buttonIndex)
                selector = 1
            }
        }
        else{
            sender.backgroundColor = UIColor.yellowColor()
            selector += 1
        }
        
        
    }

    @IBAction func discard(sender: AnyObject) {
        if !buttonholder.isEmpty {
            var lastMove = buttonholder.removeLast()
            setButtons[lastMove].backgroundColor = UIColor.whiteColor()
            setButtons[lastMove].enabled = true
            game.reLast()
            --selector
            updateGUI(lastMove)
            var holderC = " + "
            var plusN = NSMutableAttributedString(string: holderC, attributes: [NSFontAttributeName:UIFont(name: "Arial", size: 18.0)!])
            var clear = ""
            var clearMut = NSMutableAttributedString(string: clear)
            output.attributedText = clearMut
            for x in buttonholder {
                
                clearMut.appendAttributedString(setButtons[x].currentAttributedTitle!)
                clearMut.appendAttributedString(plusN)
                output.attributedText=clearMut
            }
            
        }
        else{
            
        }
        
    }
    
    @IBAction func Reset() {
        selector = 0
        turnN = 0
        /*Since this is an imperfect SET game in that not all cards on the page will matchI decided that the score will last after reset. This is to show that the player has realized there are no more matches and moves on to the next game. Will take off one point though */
        scoreN = 0
        deck = SetCardDeck()
        game = SetGame(numCards: setButtons.count, theDeck: deck)
        updateGUI(true)
        turn.text = "Turn: " + String(turnN)
        score.text = "Score: " + String(scoreN)
        output.text = ""
        history.text = ""
        buttonholder = []
    }
    
    
    func save(){
        var saveState: Bool = true
        var shapeEnc: [String] = []
        var colorEnc: [String] = []
        var shadeEnc: [String] = []
        var numEnc: [String] = []
        
        var x = 0
        while x < setButtons.count {
            shapeEnc.append(game.retCard(x).shape)
            colorEnc.append(game.retCard(x).valCol)
            shadeEnc.append(game.retCard(x).Fill)
            numEnc.append(game.retCard(x).num)
            x += 1
        }
        
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setBool(saveState, forKey: "testing")
        defaults.setObject(numEnc, forKey: "numData")
        defaults.setObject(shadeEnc, forKey: "shadeData")
        defaults.setObject(colorEnc, forKey: "colorData")
        defaults.setObject(shapeEnc, forKey: "shapeData")
        defaults.setObject(turnN, forKey: "turn")
        defaults.setObject(selector, forKey: "selector")
        defaults.setObject(scoreN, forKey: "score")
        defaults.setObject(buttonholder, forKey: "buttonpos")
    

    }
    func load(){
        
        
        
        
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        if let diction = defaults.objectForKey("numData") as? [String] {
            numDec = diction
        }
        
        if let howto = defaults.objectForKey("shadeData") as? [String] {
            shadeDec = howto
                
        }
        
        if let howthree = defaults.objectForKey("colorData") as? [String] {
            colorDec = howthree as [String]
                
        }
        if let howfour = defaults.objectForKey("shapeData") as? [String] {
            shapeDec = howfour
                
        }
        if let howfive = defaults.objectForKey("turn") as? Int {
            turnN = howfive
        }
        if let howsix = defaults.objectForKey("selector") as? Int {
            selector = howsix
        }
        if let howseven = defaults.objectForKey("score") as? Int {
            scoreN = howseven
        }
        if let howeight = defaults.objectForKey("buttonpos") as? [Int] {
            buttonholder = howeight
        }
        deck = SetCardDeck()
        game = SetGame(numCards: setButtons.count , theDeck: deck)
        game.clearCardIn()
        game.clear()
        var x = 0
        var shape: String
        var color: String
        var shade: String
        var num: String
        var tCard : SetCard!
        while  x < setButtons.count{
            shape = shapeDec[x]
             color = colorDec[x]
             shade = shadeDec[x]
             num = numDec[x]
             tCard = SetCard(shape: shape, valCol: color, Fill: shade, num: num)
            
            game.mod(tCard)
            //setButtons[x].setAttributedTitle(tCard.contents, forState: UIControlState.Normal)
            x += 1
        }
        x = 0
        var holder: Int
        var imaginary: String = ""
        var setter: NSMutableAttributedString = NSMutableAttributedString(string: imaginary)
        updateGUI(false)
        var holderC = " + "
        var plusN = NSMutableAttributedString(string: holderC, attributes: [NSFontAttributeName:UIFont(name: "Arial", size: 18.0)!])
        while x < buttonholder.count {
             holder = buttonholder[x]
            setButtons[holder].backgroundColor = UIColor.yellowColor()
            game.appCard(holder)
            setter.appendAttributedString(setButtons[holder].currentAttributedTitle!)
            setter.appendAttributedString(plusN)
            x += 1
        }
        output.attributedText = setter
        turn.text = "Turn: " + String(turnN)
        score.text = "Score: " + String(scoreN)
        history.text = ""
        
        
       
       
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (self.isMovingFromParentViewController() ) {
            save()
        }
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //load()
        //Reset()
        var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        var test: AnyObject? =  defaults.objectForKey("testing")
        if test != nil {
            load()
        }
        else{
            Reset()
        }
        
        
        
    
        
    }
}

