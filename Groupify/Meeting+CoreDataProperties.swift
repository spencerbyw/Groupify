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

    @NSManaged var time: NSDate?
    @NSManaged var place: String?
    @NSManaged var start_time: NSDate?
    @NSManaged var end_time: NSDate?

}
