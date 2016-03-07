//
//  DogViewController.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/6.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import SwiftyJSON
import SWRevealViewController

class DogViewController: UIViewController , NSURLSessionDelegate, NSURLSessionDownloadDelegate {
    var objects = [AnyObject]()
    var arrRes = [[String:AnyObject]]()
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var tab: UITableView!
    @IBOutlet weak var menuItem: UIBarButtonItem!


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connect2()
        
        //menu滑動
        revealViewController().rearViewRevealWidth = 80
        menuItem.target = self.revealViewController()
        menuItem.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //添加刷新
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("refreshData"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //=== tableView ===
    
    // 設定表格的列數
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int{
        //        print(arrRes.count)
        return arrRes.count
    }
    
    // 表格的儲存格設定
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        
        let cell:DogViewCell = tableView.dequeueReusableCellWithIdentifier("dog", forIndexPath: indexPath) as! DogViewCell
        
        let dict = arrRes[indexPath.row]
        
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
    
    
    func connect(){
        let cat = "貓".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let url = "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f4a75ba9-7721-4363-884d-c3820b0b917cq=\(cat)"
        print(url)
             
        Alamofire.request(.GET, url).responseJSON { (responseData) -> Void in
            let swiftyJsonVar = JSON(responseData.result.value!)
            
            if let resData = swiftyJsonVar["result"]["results"].arrayObject {
                self.arrRes = resData as! [[String:AnyObject]]
            }
            
            if self.arrRes.count > 0 {
                self.tab.reloadData()
            }
        }
    }
    
    func connect2(){

        var dog = "犬".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        let url = NSURL(string: "http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=f4a75ba9-7721-4363-884d-c3820b0b917c&q=\(dog)")
        
        //建立一般的session設定
        let sessionWithConfigure = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        //設定委任對象為自己
        let session = NSURLSession(configuration: sessionWithConfigure, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
        
        //設定下載網址
        if let tempUrl = url {
            if let check:NSURLSessionDownloadTask = session.downloadTaskWithURL(tempUrl){
                let dataTask = check
                //啟動或重新啟動下載動作
                dataTask.resume()
            }
        }
    }
    
    
    
    func URLSession(session: NSURLSession, downloadTask: NSURLSessionDownloadTask, didFinishDownloadingToURL location: NSURL) {
        
        do {
            
            //JSON資料處理
            let dataDic = try NSJSONSerialization.JSONObjectWithData(NSData(contentsOfURL: location)!, options: NSJSONReadingOptions.MutableContainers) as! [String:[String:AnyObject]]
            
            //取得result對應中的results所對應的陣列
            self.arrRes = dataDic["result"]!["results"] as! [[String:AnyObject]]
            
            //重新整理Table View
            self.tab.reloadData()
            
        } catch {
            print("Error!")
        }
        
    }

    
    
    // 刷新數據
    func refreshData() {
        self.tab.reloadData()
        self.refreshControl!.endRefreshing()
    }

}
