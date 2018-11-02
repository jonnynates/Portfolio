//
//  QuestionCore+CoreDataProperties.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 14/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//
//

import Foundation
import CoreData


extension QuestionCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuestionCore> {
        return NSFetchRequest<QuestionCore>(entityName: "QuestionCore")
    }

    @NSManaged public var id: String?
    @NSManaged public var numeric: Numeric?
    @NSManaged public var single: Single?
    @NSManaged public var text: Text?
    @NSManaged public var multi: NSSet?

}

// MARK: Generated accessors for multi
extension QuestionCore {

    @objc(addMultiObject:)
    @NSManaged public func addToMulti(_ value: Multi)

    @objc(removeMultiObject:)
    @NSManaged public func removeFromMulti(_ value: Multi)

    @objc(addMulti:)
    @NSManaged public func addToMulti(_ values: NSSet)

    @objc(removeMulti:)
    @NSManaged public func removeFromMulti(_ values: NSSet)

}
