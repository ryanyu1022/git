//
//  Animal.swift
//  LoveAnimal
//
//  Created by ryan on 2016/3/29.
//  Copyright © 2016年 ryan. All rights reserved.
//

import Foundation
import CoreData


class Animal: NSManagedObject {

    static let entityName = "Animal"
    
    //新增
    class func add(moc:NSManagedObjectContext,receive:[String:AnyObject]){
        
        let animal = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: moc) as! Animal
        
        animal.name = receive["Name"] as! String
        animal.sex = receive["Sex"] as! String
        animal.type = receive["Type"] as! String
        animal.build = receive["Build"] as! String
        animal.variety = receive["Variety"] as! String
        animal.isSterilization = receive["IsSterilization"] as! String
        animal.hairType = receive["HairType"] as! String
        animal.acceptNum = receive["AcceptNum"] as! String
        animal.note = receive["Note"] as! String
        animal.phone = receive["Phone"] as! String
        animal.email = receive["Email"] as! String
        animal.resettlement = receive["Resettlement"] as! String
        animal.imageName = receive["ImageName"] as! String

        do {
            try moc.save()
        }catch{
            fatalError("Failure to save context: \(error)")
        }
    }
    
    // 顯示
    class func show(moc:NSManagedObjectContext) -> Array<Animal>{
        let request = NSFetchRequest(entityName: entityName)
        var animal:Array<Animal> = [] //存資料庫的陣列
        
        do {
            animal = try moc.executeFetchRequest(request) as! [Animal]
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
        return animal
    }
    
    //刪除
    class func delete(moc:NSManagedObjectContext, data:NSManagedObject){
        let request = NSFetchRequest(entityName: entityName)
        
        // 刪除core data資料
        moc.deleteObject(data)

        do {
            try moc.save()
        }catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
        }
    }
    

}
