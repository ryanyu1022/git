//
//  Animal+CoreDataProperties.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/29.
//  Copyright © 2016年 ryan. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Animal {

    @NSManaged var name: String?
    @NSManaged var sex: String?
    @NSManaged var type: String?
    @NSManaged var build: String?
    @NSManaged var variety: String?
    @NSManaged var isSterilization: String?
    @NSManaged var hairType: String?
    @NSManaged var acceptNum: String?
    @NSManaged var note: String?
    @NSManaged var phone: String?
    @NSManaged var email: String?
    @NSManaged var resettlement: String?
    @NSManaged var imageName: String?
    
    
}
