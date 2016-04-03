//
//  Member+CoreDataProperties.swift
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

extension Member {

    @NSManaged var name: String?
    @NSManaged var phone: String?
    @NSManaged var email: String?
    @NSManaged var group_name: String?
    @NSManaged var group_number: String?
    @NSManaged var address: String?
    @NSManaged var profile_picture: NSData?
    @NSManaged var meeting_availability_start: NSDate?
    @NSManaged var meeting_availability_end: NSDate?

}
