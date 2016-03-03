//
//  SaveListViewController.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/3.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit

class SaveListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        Open.target = self.revealViewController()
        //        Open.action = Selector("revealToggle:")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
