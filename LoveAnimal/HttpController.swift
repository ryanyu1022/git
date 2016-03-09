//
//  HttpController.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/8.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//以results傳送讀取的資料
protocol HttpProtocol {
    func didReceiveResults(results:[[String:AnyObject]])
}

class HttpController:NSObject {
    var delegate:HttpProtocol?
    var arrRes = [[String:AnyObject]]()
    

    func connect(urla:String){
        
        Alamofire.request(.GET, urla).responseJSON { (responseData) -> Void in
            let swiftyJsonVar = JSON(responseData.result.value!)
            
            if let resData = swiftyJsonVar["result"]["results"].arrayObject {
                self.arrRes = resData as! [[String:AnyObject]]
                print(self.arrRes)
                self.delegate?.didReceiveResults(self.arrRes)
            }
        }
        
        
    }
    
    
    //AJAX讀取網頁資料類別
//    func onSearch(urla:String) {
//        let url:NSURL = NSURL(string: "http://data.taipei.gov.tw/opendata/apply/json/QTdBNEQ5NkQtQkM3MS00QUI2LUJENTctODI0QTM5MkIwMUZE")!
//        let request:NSURLRequest = NSURLRequest(URL: url)
//        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:
//            {( response:NSURLResponse?, data:NSData?, error:NSError?) -> Void in
//                let httpResponse = response as? NSHTTPURLResponse
//                if httpResponse?.statusCode == 200 {
//                    let array: NSArray = try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSArray
//                    self.delegate?.didReceiveResults(array)
//                }
//                
//            } // Closure 定義結束
//        )
//    }
}

