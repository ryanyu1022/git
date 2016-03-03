//
//  ListViewController.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/3.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import SWRevealViewController

class ListViewController: UIViewController {
    
    var objects = [AnyObject]()
    var arrRes = [[String:AnyObject]]()
    var refreshControl:UIRefreshControl!
    @IBOutlet weak var tab: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Open.target = self.revealViewController()
//        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //添加刷新
        var refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refreshData"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
        connect()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //=== tableView ===
    
    // 設定表格的列數
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        print(arrRes.count)
        return arrRes.count
    }
    
    // 表格的儲存格設定
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {

        let cell:ListViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ListViewCell

        let dict = arrRes[indexPath.row]
        
        let img = dict["ImageName"] as! String
        var name = dict["Name"] as! String
        if name == ""{
            name = "無資料"
        }
        let type = dict["Type"] as! String
        let variety = dict["Variety"] as! String
        
        cell.setCell(img, name: name, type: type, variety: variety)
        
        // Circular image
        cell.img.layer.cornerRadius = cell.img.frame.size.width / 2
        cell.img.clipsToBounds = true
        //border image
        cell.img.layer.borderWidth = 4
        cell.img.layer.borderColor = UIColor.grayColor().CGColor
        
        
        return cell
    }
    
    
    func connect(){
        Alamofire.request(.GET, "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f4a75ba9-7721-4363-884d-c3820b0b917c").responseJSON { (responseData) -> Void in
            let swiftyJsonVar = JSON(responseData.result.value!)
            
            if let resData = swiftyJsonVar["result"]["results"].arrayObject {
                self.arrRes = resData as! [[String:AnyObject]]
            }
            
            if self.arrRes.count > 0 {
                self.tab.reloadData()
            }
        }
    }

    // 刷新數據
    func refreshData() {
        self.tab.reloadData()
        self.refreshControl!.endRefreshing()
    }
}
