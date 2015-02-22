//
//  SetCard.swift
//  SetCardGame
//
//  Created by Paul Searcy on 2/14/15.
//  Copyright (c) 2015 Paul Searcy. All rights reserved.
//

import Foundation
import UIKit

class SetCard : Card {
    
    let shape: String
    let valCol: String
    let Fill: String
    let num : String
    init(shape:String, valCol:String, Fill:String, num:String) {
        self.shape = shape
        self.valCol = valCol
        self.Fill = Fill
        self.num = num
        super.init()
    }
    
    class func valShape() -> [String] {
        return ["□","○", "△"]
    }
    
    class func valColor() -> [String]{
        return ["red","blue","green"]
    }
    
    class func valFill() -> [String]{
        return ["fill","nofill","opaq"]
    }
    class func ranInt() ->[String]{
        return ["1","2","3"]
    }
    func retSh() -> String {
        return shape
    }
    func retVC() -> String {
        return valCol
    }
    func retFill() -> String{
        return Fill
    }
    func retNum() -> String {
        return num
    }
    /* Functions that take the variables from the card and apply attributes to the string that will represent them on the screen. */
    class func coloring(attString: NSMutableAttributedString, notify: String) ->NSMutableAttributedString{
        var copy = attString
        if (notify == "red"){
            copy.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location:0,length:1))
        }
        else if (notify == "blue"){
            copy.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSRange(location:0,length:1))
        }
        else if (notify == "green"){
            copy.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSRange(location:0,length:1))
        }
        return copy
    }
    class func filling(attString: NSMutableAttributedString, notify: String, colflag: String)-> NSMutableAttributedString{
        
        var copy = attString
        if (notify == "fill"){
            copy.addAttribute(NSStrokeWidthAttributeName, value: 25, range: NSRange(location: 0, length: 1))
        }
        else if (notify == "opaq"){
            if colflag == "red"{
                copy.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 1, green: 0, blue: 0, alpha: 0.4), range: NSRange(location:0,length:1))
                copy.addAttribute(NSStrokeWidthAttributeName, value: 25, range: NSRange(location: 0, length: 1))
            }
            else if colflag == "blue"{
                copy.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 0, green: 0, blue: 1, alpha: 0.4), range: NSRange(location:0,length:1))
                copy.addAttribute(NSStrokeWidthAttributeName, value: 25, range: NSRange(location: 0, length: 1))            }
            else if colflag == "green"{
                copy.addAttribute(NSForegroundColorAttributeName, value: UIColor(red: 1, green: 1, blue: 0, alpha: 0.4), range: NSRange(location:0,length:1))
                copy.addAttribute(NSStrokeWidthAttributeName, value: 25, range: NSRange(location: 0, length: 1))            }
        
            
        }
        return copy
    }
    class func replicate(attString: NSMutableAttributedString, notify: String) -> NSMutableAttributedString{
        var copy = NSMutableAttributedString(attributedString: attString)
        
        if ( notify == "3"){
            attString.appendAttributedString(copy)
            
            attString.appendAttributedString(copy)
        
            
            copy = attString
            return copy
        }
        else if ( notify == "2"){
            attString.appendAttributedString(copy)
            copy = attString
            return copy
        }
        else  if (notify == "1"){
            
            return copy
        }
        return copy
    }
    override var contents : NSMutableAttributedString {
        get{
            
            var attString = NSMutableAttributedString(string: shape)
            attString = SetCard.coloring(attString, notify: valCol)
            attString = SetCard.filling(attString, notify: Fill, colflag: valCol)
            attString = SetCard.replicate(attString, notify: num)
            return attString
            }
        }
    }
