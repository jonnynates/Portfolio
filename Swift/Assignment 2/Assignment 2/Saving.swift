//
//  Saving.swift
//  Assignment 2
//
//  Created by Jonathan Nates on 04/12/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import Foundation
import CoreData

class Saving {
    
    //This function is responsible for fetching all the data to be stored into core data
    //Once all data is fetched it then saves the information
    func saveToCore(id: String, title: String, artist: String, yearOfWork: String, information: String, lat: Double, long: Double, location: String, locationNotes: String, fileName: String, lastModified: String, distance: Double )
    {
        let art: Artwork = NSEntityDescription.insertNewObject(forEntityName: "Artwork", into: PersistenceService.context) as! Artwork
        
        art.id = Int16(id)!
        art.title = title
        art.artist = artist
        art.yearOfWork = yearOfWork
        art.information = information
        art.lat = lat
        art.long = long
        art.location = location
        art.locationNotes = locationNotes
        art.fileName = fileName
        art.lastModified = lastModified
        art.distance = distance
        
        PersistenceService.saveContext()
    }
    
        
}
