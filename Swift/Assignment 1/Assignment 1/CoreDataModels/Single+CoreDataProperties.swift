//
//  Single+CoreDataProperties.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 14/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//
//

import Foundation
import CoreData


extension Single {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Single> {
        return NSFetchRequest<Single>(entityName: "Single")
    }

    @NSManaged public var answer: Int16
    @NSManaged public var question: String?
    @NSManaged public var questionlink: QuestionCore?

}
