//
//  Artwork+CoreDataProperties.swift
//  Assignment 2
//
//  Created by Jonathan Nates on 12/12/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//
//

import Foundation
import CoreData


extension Artwork {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artwork> {
        return NSFetchRequest<Artwork>(entityName: "Artwork")
    }

    @NSManaged public var artist: String?
    @NSManaged public var distance: Double
    @NSManaged public var fileName: String?
    @NSManaged public var id: Int16
    @NSManaged public var information: String?
    @NSManaged public var lastModified: String?
    @NSManaged public var lat: Double
    @NSManaged public var location: String?
    @NSManaged public var locationNotes: String?
    @NSManaged public var long: Double
    @NSManaged public var title: String?
    @NSManaged public var yearOfWork: String?

}
