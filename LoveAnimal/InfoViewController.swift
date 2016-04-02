//
//  InfoViewController.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/24.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit
import SWRevealViewController

class InfoViewController: UIViewController {
    
    @IBOutlet weak var menuItem: UIBarButtonItem!
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var txtView: UITextView!
    var content:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //menu滑動
        revealViewController().rearViewRevealWidth = 85
        menuItem.target = self.revealViewController()
        menuItem.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        //認養資訊內容
        content.appendContentsOf("本APP資料來自於臺北市政府，提供動動之家、臺北市流浪貓保護協會以及臺北市愛兔協會等民間動物保護團體相關動物認養資訊")
        content.appendContentsOf("提供犬、貓以及免子等動物基本資料以及聯絡方式，鼓勵民眾「以認養代替購買」\n\n")
        content.appendContentsOf("臺北市動物之家\n")
        content.appendContentsOf("地址: 台北市內湖區潭美街852號\n")
        content.appendContentsOf("電話: 02-87913254\n")
        content.appendContentsOf("傳真: 02-27913867\n")
        content.appendContentsOf("開放時間: \n")
        content.appendContentsOf("周二至周日 上午 10:00~12:30\n")
        content.appendContentsOf("周二至周日 下午 1:30~4:00\n\n")

        content.appendContentsOf("臺北市流浪貓保護協會\n")
        content.appendContentsOf("地址: 臺北市信義區信義路六段81號\n")
        content.appendContentsOf("洽公專線:02-27261079(捐款、捐贈詢問、洽公..等)(平日白天,國定假日休)\n")
        content.appendContentsOf("送養中心住址：110台北市信義區信義路六段81號(每日下午2點至晚間8點)\n")
        content.appendContentsOf("認養洽詢：02-27263263\n")
        content.appendContentsOf("\n")
        
        content.appendContentsOf("愛兔協會 \n")
        content.appendContentsOf("地址: 台北市內湖區內湖路一段73號內湖號3樓(鄰近捷運劍南站)\n")
        content.appendContentsOf("電話: 0922560178\n")
        content.appendContentsOf("傳真: 02-26275418\n")
        content.appendContentsOf("開放時間：週二至六 13:00 - 20:00")
        
        txtView.text = content
        txtView.userInteractionEnabled = true
        txtView.editable = false
        txtView.font = UIFont.systemFontOfSize(30)
        
        txtView.layer.borderWidth = 5
        txtView.layer.cornerRadius = 10
        txtView.layer.borderColor = UIColor.whiteColor().CGColor
        

    }
}