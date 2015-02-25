//
//  CarLot.swift
//  CarLot
//
//  Created by xiaolei3 on 15/2/25.
//  Copyright (c) 2015年 michael. All rights reserved.
//

import Foundation
import CoreData

class CarLot: NSManagedObject {

    @NSManaged var price: NSDecimalNumber
    @NSManaged var photo: AnyObject
    @NSManaged var onSpecial: NSNumber
    @NSManaged var makeModel: String
    @NSManaged var datePurchased: NSDate
    @NSManaged var condition: NSNumber

}
