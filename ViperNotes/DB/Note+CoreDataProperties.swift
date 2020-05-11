//
//  Note+CoreDataProperties.swift
//  ViperNotes
//
//  Created by Ignacio Acisclo on 08/05/2020.
//  Copyright © 2020 Ignacio Acisclo. All rights reserved.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var body: String
    @NSManaged public var date: Date
    @NSManaged public var title: String
    @NSManaged public var id: UUID

}
