//
//  RearTableViewController.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/3.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit

class RearTableViewController: UITableViewController {
    var TableArray = [String]()
    
    override func viewDidLoad() {
        TableArray = ["main","save"]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = TableArray[indexPath.row]
        
        return cell
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        var vc =  segue.destinationViewController as! ViewController
    ////        var indexPath:NSIndexPath = self.tableView.indexPathForSelectedRow!
    //        if let indexPath  = self.tableView.indexPathForSelectedRow {
    //            vc.varView = indexPath.row
    //        }
    //    }
}

