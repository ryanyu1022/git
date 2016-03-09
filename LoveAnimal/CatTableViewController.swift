//
//  CatTableViewController.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/9.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import SWRevealViewController

class CatTableViewController: UITableViewController ,NSURLSessionDelegate,NSURLSessionDownloadDelegate{

    //    var objects = [AnyObject]()
    //    var arrRes = [[String:AnyObject]]()
    var dataArray = [AnyObject]() //儲存動物資料
    @IBOutlet weak var menuItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //menu滑動
        revealViewController().rearViewRevealWidth = 80
        menuItem.target = self.revealViewController()
        menuItem.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        let param = "貓".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        
        //網址
        let url = NSURL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f4a75ba9-7721-4363-884d-c3820b0b917c&q=\(param)")
        print(url)
        
        //建立一般的session設定
        let sessionWithConfigure = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        //設定委任對象為自己
        let session = NSURLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        //設定下載網址
        let dataTask = session.downloadTaskWithURL(url!)
        
        //啟動或重新啟動下載動作
        dataTask.resume()
        
    }
    
    //=== tableView ===
    
    // 設定表格的列數
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataArray.count)
        return dataArray.count
    }
    
    // 表格的儲存格設定
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:CatViewCell = tableView.dequeueReusableCellWithIdentifier("cat", forIndexPath: indexPath) as! CatViewCell
        
        let dict = dataArray[indexPath.row]
        
        let img = dict["ImageName"] as! String
        var name = dict["Name"] as! String
        if name == ""{
            name = "無資料"
        }
        var type = dict["Type"] as! String
        if type == "其他"{
            type = "兔"
        }
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
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        do {
            
            //JSON資料處理
            let dataDic = try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL: location)!, options: NSJSONReadingOptions.MutableContainers) as! [String:[String:AnyObject]]
            
            //依據先前觀察的結構，取得result對應中的results所對應的陣列
            dataArray = dataDic["result"]!["results"] as! [AnyObject]
            
            //重新整理Table View
            self.tableView.reloadData()
            
        } catch {
            print("Error!")
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

