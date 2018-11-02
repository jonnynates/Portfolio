//
//  Saving.swift
//  Places I've Been
//
//  Created by Jonathan Nates on 15/12/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import Foundation
import CoreData

class Saving {
    
    func saveToCore(placeName: String)
    {
        let place: Places = NSEntityDescription.insertNewObject(forEntityName: "Places", into: PersistenceService.context) as! Places
        
        place.name = placeName
        
        PersistenceService.saveContext()
    }
    
    
}
