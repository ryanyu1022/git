//
//  ListTableViewController.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/8.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import SWRevealViewController

class SaveTableViewController: UITableViewController{
    

    @IBOutlet weak var menuItem: UIBarButtonItem!
    //存資料庫的陣列
    var result = Array<Animal>()
    //宣告代理物件操作core data
    let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        result = Animal.show(moc)
        self.tableView.reloadData()
        
        //menu滑動
        revealViewController().rearViewRevealWidth = 85
        menuItem.target = self.revealViewController()
        menuItem.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }
    
    //=== tableView ===
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        var numOfSection: NSInteger = 0
        
        if result.count > 0 {
            
            self.tableView.backgroundView = nil
            numOfSection = 1
            
            
        } else {
            self.tableView!.tableFooterView = UIView()  //去除分隔線
            
            //顯示訊息label
            var noDataLabel: UILabel = UILabel(frame: CGRectMake(0, 0, self.tableView.bounds.size.width, self.tableView.bounds.size.height))
            noDataLabel.text = "目前尚未有收藏!"
            noDataLabel.textColor = UIColor(red: 22.0/255.0, green: 106.0/255.0, blue: 176.0/255.0, alpha: 1.0)
            noDataLabel.textAlignment = NSTextAlignment.Center
            noDataLabel.textColor = UIColor.whiteColor()
            noDataLabel.font = UIFont.systemFontOfSize(24)
            self.tableView.backgroundView = noDataLabel
            //背景
            self.tableView.backgroundColor = UIColor.lightGrayColor()
            //標題
            self.title = "收藏記錄: 無"
            
        }
        
        return numOfSection
    }
    
    // 設定表格的列數
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return result.count
    }
    
    // 表格的儲存格設定
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:SaveViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SaveViewCell
        
            let dict = result[indexPath.row]
            
            let img:String! = dict.imageName
            
            var name:String! = dict.name
            if name == ""{
                name = "無資料"
            }
            let sex:String! = dict.sex
            let variety:String! = dict.variety
            
            cell.setCell(img, name: name, sex: sex, variety: variety)
            
            // Circular image
            cell.img.layer.cornerRadius = cell.img.frame.size.width / 2
            cell.img.clipsToBounds = true
            //border image
            cell.img.layer.borderWidth = 4
            cell.img.layer.borderColor = UIColor.grayColor().CGColor
            
            self.title = "收藏記錄: 共有 \(result.count) 隻動物"
        
        return cell
    }
    
    // 設定滑動後顯示紅色刪除按鈕
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle{
        return UITableViewCellEditingStyle.Delete
    }
    
    // 按下刪除按鈕，刪除該儲存格資料
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath){
        
        // 刪除core data資料
        Animal.delete(moc, data: result[indexPath.row])
        // 刪除該儲存格資料
        result.removeAtIndex(indexPath.row)
        
        tableView.beginUpdates()
        
        if tableView.numberOfRowsInSection(indexPath.section) == 1{
            tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: .Automatic)
        }else{
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }

//        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        tableView.endUpdates()

        Animal.show(moc)
        tableView.reloadData()

    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destinationController = segue.destinationViewController as! CatDetailViewController

                destinationController.receiveObj = result[indexPath.row]
                
                //回前頁按鈕
                let backItem = UIBarButtonItem()
                backItem.title = "回前頁"
                navigationItem.backBarButtonItem = backItem
            }
        }
    }

    
}
