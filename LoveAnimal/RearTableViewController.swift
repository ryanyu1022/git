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
    @IBOutlet var tab: UITableView!
    
    override func viewDidLoad() {
        
        //移除空的cell分隔線
        tab.tableFooterView = UIView(frame:CGRectZero)
        tab.separatorColor = UIColor.grayColor()
        
        TableArray = ["title","info","dog","cat","rabbit","save","temp"]
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var cell = tableView.dequeueReusableCellWithIdentifier(TableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell

        
        return cell
    }
    
//    func setFont(label:UILabel){
//        label.font =  UIFont(name: "Avenir-Light", size: 25.0)
//    }

}

