//
//  Numeric+CoreDataProperties.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 13/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//
//

import Foundation
import CoreData


extension Numeric {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Numeric> {
        return NSFetchRequest<Numeric>(entityName: "Numeric")
    }

    @NSManaged public var value: Int16
    @NSManaged public var questionlink: QuestionCore?

}
