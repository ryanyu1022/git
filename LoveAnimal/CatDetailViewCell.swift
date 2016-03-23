//
//  CatDetailViewCell.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/10.
//  Copyright © 2016年 ryan. All rights reserved.
//

import UIKit

class CatDetailViewCell: UITableViewCell {


    @IBOutlet weak var fieldLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
