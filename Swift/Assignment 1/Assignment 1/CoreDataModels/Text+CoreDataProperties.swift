//
//  Text+CoreDataProperties.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 13/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//
//

import Foundation
import CoreData


extension Text {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Text> {
        return NSFetchRequest<Text>(entityName: "Text")
    }

    @NSManaged public var text: String?
    @NSManaged public var questionlink: QuestionCore?

}
