//
//  CatViewCell.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/8.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit

class CatViewCell: UITableViewCell {
   
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var variety: UILabel!
    
    func setCell(catImage:String,name:String,type:String,variety:String){
        
        let url = NSURL(string: catImage)
        if let image = NSData(contentsOfURL: url!){
            self.img.image = UIImage(data: image)
        }
        //        let image = NSData(contentsOfURL: url!)
        //        self.img.image = UIImage(data: image!)
        
        self.name.text = name
        self.type.text = type
        self.variety.text = variety
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}