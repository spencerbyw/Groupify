//
//  Meeting+CoreDataProperties.swift
//  Groupify
//
//  Created by Spencer.Bywater on 4/2/16.
//  Copyright © 2016 Spencer.Bywater. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Meeting {

    @NSManaged var date_time: String?
    @NSManaged var group_name: String?
    @NSManaged var members_available: String?
    @NSManaged var places: String?
    @NSManaged var real_date: NSDate?

}
