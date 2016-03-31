//
//  CatDetailViewController2.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/11.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit
import MessageUI
import Social

class CatDetailViewController: UIViewController ,MFMailComposeViewControllerDelegate {

    var receive = [String:AnyObject]() //儲存動物資料
    var receiveObj:Animal?     //儲存動物資料
    var buttonTitle:String = ""
    //動物資料
    var name = "", sex = "", build = "", variety = "", isSterilization = "", hairType = ""
    var acceptNum = "", note = "", phone = "", email = "", resettlement = "", imageName = ""
    
    @IBOutlet weak var tab: UITableView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var saveItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setData()
        setImage()
        setView()
        
        //menu滑動
        revealViewController().rearViewRevealWidth = 80
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }
    

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("detail", forIndexPath: indexPath) as! CatDetailViewCell
            
            switch indexPath.row {
            case 0:
                cell.fieldLabel.text = "名字:"
                var checkName = self.name
                if checkName == ""{
                    checkName = "無資料"
                }
                cell.valueLabel.text = (checkName)
            case 1:
                cell.fieldLabel.text = "性別:"
                cell.valueLabel.text = (self.sex)
            case 2:
                cell.fieldLabel.text = "體型:"
                cell.valueLabel.text = (self.build)
            case 3:
                cell.fieldLabel.text = "品種:"
                cell.valueLabel.text = (self.variety)
            case 4:
                cell.fieldLabel.text = "絕育:"
                cell.valueLabel.text = (self.isSterilization)
            case 5:
                cell.fieldLabel.text = "毛色:"
                cell.valueLabel.text = (self.hairType)
            case 6:
                cell.fieldLabel.text = "領養編號:"
                cell.valueLabel.text = (self.acceptNum)
            case 7:
                cell.fieldLabel.text = "描述:"
                cell.valueLabel.text = (self.note)
            case 8:
                cell.fieldLabel.text = "聯絡電話:"
                cell.valueLabel.text = (self.phone)
            case 9:
                cell.fieldLabel.text = "信箱:"
                cell.valueLabel.text = (self.email)
            default:
                cell.fieldLabel.text = ""
                cell.valueLabel.text = ""
                
            }
            return cell
    }
    
    @IBAction func callAction(sender: AnyObject) {
        
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "是否要撥打電話?"
        alertView.message = phone
        alertView.delegate = self
        alertView.addButtonWithTitle("取消")
        alertView.addButtonWithTitle("通話")
        alertView.show()
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int){
        // 取得按鈕的文字
        
        buttonTitle = alertView.buttonTitleAtIndex(buttonIndex)!
        switch (buttonIndex) {
        case 0: // 按下 取消 鈕的處理
            print("取消")
            break
        case 1: // 按下 確定 鈕的處理
            //自動打開撥號頁面並自動撥打電話
            let phoneNumber = receive["Phone"] as! String
            UIApplication.sharedApplication().openURL(NSURL(string :"tel://\(phoneNumber)")!)
        default: // 其他的狀況
            break
        }
    }
    
    @IBAction func emailAction(sender: AnyObject) {
        
        let mailComposeViewController = configuredMailComposeViewController()
        //判斷能否寄信
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }

    //發送郵件代理方法
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        
        let place:String = receive["Resettlement"] as! String   //收容位置
        var name:String = receive["Name"] as! String   //名字
        let number:String = receive["AcceptNum"] as! String   //編號
//        let imgUrl = receive["ImageName"] as! String   //圖片
        if name.containsString("無資料") {
            name = ""
        }
        
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([receive["Email"] as! String])
        if place.containsString("愛免協會") {
            mailComposerVC.setSubject("愛免協會 你好")
        }else if place.containsString("動物之家"){
            mailComposerVC.setSubject("動物之家 你好")
        }else if place.containsString("流浪貓保護協會"){
            mailComposerVC.setSubject("流浪貓保護協會 你好")
        }else{
            mailComposerVC.setSubject("\(place) 你好")
        }
        
        mailComposerVC.setMessageBody("你好 \n我想認養\(name) \n領養編號是\(number)", isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    func mailComposeController(controller: MFMailComposeViewController!, didFinishWithResult result: MFMailComposeResult, error: NSError!) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    @IBAction func mapAction(sender: AnyObject) {
        
        let place:String = resettlement   //收容位置
        var param = ""
        
        if place.containsString("愛免協會") {
             param = "愛免協會".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        }else if place.containsString("動物之家"){
             param = "動物之家".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        }else if place.containsString("臺北市流浪貓保護協會"){
             param = "臺北市流浪貓保護協會".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        }else{
             param = place.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        }
        
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string:"comgooglemaps://?q=\(param)&zoom=14&views=traffic")!)
            
        } else {
            //itms-apps://itunes.apple.com/app/
            UIApplication.sharedApplication().openURL(NSURL(string:"itms-apps://itunes.apple.com/app/")!)
        }
        
        
    }
    
    @IBAction func shareAction(sender: AnyObject) {
        
        //建立UIAlertController
        let ac: UIAlertController = UIAlertController(title: "", message: "分享至", preferredStyle: .ActionSheet)
        //取消
        let cancel: UIAlertAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        //LINE
        let line: UIAlertAction = UIAlertAction(title: "LINE", style: .Default) { action -> Void in
            if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"line://")!)) {
                
                var place = ""
                if self.resettlement.containsString("愛免協會") {
                    place = "愛免協會"
                }else if self.resettlement.containsString("動物之家"){
                    place = "臺北市動物之家"
                }else if self.resettlement.containsString("臺北市流浪貓保護協會"){
                    place = "臺北市流浪貓保護協會"
                }else{
                    place = self.resettlement
                }
                
                let tempContent = "我來自\(place),我的編號是\(self.acceptNum),快來看我吧...\(self.imageName)"
                
                let content = tempContent.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
                
                UIApplication.sharedApplication().openURL(NSURL(string:"line://msg/text/\(content)")!)
            } else {
                //itms-apps://itunes.apple.com/app/
                UIApplication.sharedApplication().openURL(NSURL(string:"itms-apps://itunes.apple.com/app/")!)
            }
        }
        //FB
        let fb: UIAlertAction = UIAlertAction(title: "Facebook", style: .Default) { action -> Void in
            
            // 檢查能否分享至 Facebook
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
                
                // 初始化預設的視圖控制器分享貼文
                let facebookComposeVC = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                //動物圖片網址
                let url = NSURL(string: self.imageName)
                facebookComposeVC.addURL(url)
                
                self.presentViewController(facebookComposeVC, animated: true, completion: nil)
            }
            else {

                //建立UIAlertController
                let quetion = UIAlertController(title: nil, message: "您尚未安裝Facebook", preferredStyle: .Alert)
                let callaction = UIAlertAction(title: "確定", style: .Cancel , handler:nil)
                quetion.addAction(callaction)
                
                //Show
                self.presentViewController(quetion, animated: true, completion: nil)
            }
           
        }
        
        //Twitter
        let twitter: UIAlertAction = UIAlertAction(title: "Twitter", style: .Default) { action -> Void in
            
            // 檢查能否分享至 Twitter
            if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter) {
                // 初始化預設的視圖控制器分享貼文
                let twitterComposeVC = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                
                //動物圖片網址
                let url = NSURL(string: self.imageName)
                twitterComposeVC.addURL(url)

                self.presentViewController(twitterComposeVC, animated: true, completion: nil)

            }
            else {
                //建立UIAlertController
                let quetion = UIAlertController(title: nil, message: "您尚未安裝Twitter", preferredStyle: .Alert)
                let callaction = UIAlertAction(title: "確定", style: .Cancel , handler:nil)
                quetion.addAction(callaction)
                
                //Show
                self.presentViewController(quetion, animated: true, completion: nil)
            }
        }
        
        ac.addAction(cancel)
        ac.addAction(line)
        ac.addAction(fb)
        ac.addAction(twitter)
        
        //provide a popover sourceView when using it on iPad
//        actionSheetController.popoverPresentationController?.sourceView = sender as! UIView;
        
        //Present the AlertController
        self.presentViewController(ac, animated: true, completion: nil)

    }
    
    @IBAction func saveAction(sender: AnyObject) {
        
        let moc = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext     //宣告代理物件操作core data
        let check = Animal.query(moc, acceptNum: acceptNum)
        
        if check.isEmpty {
            Animal.add(moc, receive: receive)
            
            //建立UIAlertController
            let ac = UIAlertController(title: nil, message: "收藏成功", preferredStyle: .Alert)
            let callaction = UIAlertAction(title: "確定", style: .Cancel , handler:nil)
            ac.addAction(callaction)
            
            //Show
            self.presentViewController(ac, animated: true, completion: nil)
            
        }else{
            //建立UIAlertController
            let quetion = UIAlertController(title: nil, message: "已收藏", preferredStyle: .Alert)
            let callaction = UIAlertAction(title: "確定", style: .Cancel , handler:nil)
            quetion.addAction(callaction)
            
            //Show
            self.presentViewController(quetion, animated: true, completion: nil)
        }

    }
    
    func setView(){
        // Set table view background color
        self.tab.backgroundColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.2)
        
        // Remove extra separator
        self.tab!.tableFooterView = UIView()
        
        
        // Change separator color
        self.tab.separatorColor = UIColor(red: 240.0/255.0, green: 240.0/255.0, blue: 240.0/255.0, alpha: 0.8)
        
        // Set navigation bar title
        title = self.name
        
        tab.estimatedRowHeight = 36.0;
        tab.rowHeight = UITableViewAutomaticDimension;
    }
    
    func setImage(){
        let url = NSURL(string: self.imageName)
        if let image = NSData(contentsOfURL: url!){
            self.img.image = UIImage(data: image)
        }
    }
    
    func setData(){

        // 收藏頁面
        if let re = receiveObj {
            
            //    不顯示儲存按鈕
//            saveItem.enabled = false
            navigationItem.rightBarButtonItems = []
            
            name = re.name!
            sex = re.sex!
            build = re.build!
            variety = re.variety!
            isSterilization = re.isSterilization!
            hairType = re.hairType!
            acceptNum = re.acceptNum!
            note = re.note!
            phone = re.phone!
            email = re.email!
            resettlement = re.resettlement!
            imageName = re.imageName!
        }else{  // 一般頁面
            name = receive["Name"] as! String
            sex = receive["Sex"] as! String
            build = receive["Build"] as! String
            variety = receive["Variety"] as! String
            isSterilization = receive["IsSterilization"] as! String
            hairType = receive["HairType"] as! String
            acceptNum = receive["AcceptNum"] as! String
            note = receive["Note"] as! String
            phone = receive["Phone"] as! String
            email = receive["Email"] as! String
            resettlement = receive["Resettlement"] as! String
            imageName = receive["ImageName"] as! String
        }
    }
}
