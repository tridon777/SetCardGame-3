//
//  OtherViewController.swift
//  SetCardGame
//
//  Created by Paul Searcy on 2/16/15.
//  Copyright (c) 2015 Paul Searcy. All rights reserved.
//

import UIKit

class OtherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
    var items: [String] = ["We", "Heart", "Swift"]
    override func viewDidLoad() {
        super.viewDidLoad()
        titleSet()
        if defaults.objectForKey("testing") != nil {
            `continue`.setTitle("Continue", forState: UIControlState.Normal)
        }
        self.tUsers.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var tUsers: UITableView!
    @IBOutlet weak var `continue`: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var setTitle: UILabel!
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
   
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tUsers.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("You selected cell #\(indexPath.row)!")
    }
    func titleSet(){
        
        
        var SET = NSMutableAttributedString(string: setTitle.text!, attributes: [NSFontAttributeName:UIFont(name: "Arial", size: 40)!])
        SET.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSRange(location:0,length:1))
        SET.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(), range: NSRange(location:1,length:1))
        SET.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSRange(location:2,length:1))
        
        setTitle.attributedText = SET
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
