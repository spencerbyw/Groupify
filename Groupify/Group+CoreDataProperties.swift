//
//  Group+CoreDataProperties.swift
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

extension Group {

    @NSManaged var name: String?
    @NSManaged var id: String?

}
