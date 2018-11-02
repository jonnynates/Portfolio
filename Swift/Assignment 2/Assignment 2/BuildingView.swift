//
//  BuildingView.swift
//  Assignment 2
//
//  Created by Jonathan Nates on 07/12/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

class BuildingView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //The building title
    var buildName = ""
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var navTitle: UINavigationItem!
    
    //Goes back to the map view
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Sets the navigation bar title to the title of the bulding
        navTitle.title = buildName
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Sets the number of rows to the amount of artwork within a specific building
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchRequest: NSFetchRequest<Artwork> = Artwork.fetchRequest()
        var secNum = 0
        do
        {
            //Sorts core data based on distance from current location
            let sortDescriptor = NSSortDescriptor(key: "distance", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            //Filters all the artwork in core data to only display the artwork within the building
            fetchRequest.predicate = NSPredicate(format: "location MATCHES[cd] '(\(buildName)).*'")
            
            
            let fetchResults = try PersistenceService.context.fetch(fetchRequest)
            let results = fetchResults as [Artwork] //Core Data
            //Counts only the artwork within the building (due to the filter)
            secNum = results.count
        } catch let coreErr {
            print("Error with core data", coreErr)
        }
        return secNum
    }
    
    //Displays the title of all the artworks within a building
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "myCell")
        
        let fetchRequest: NSFetchRequest<Artwork> = Artwork.fetchRequest()
        do
        {
            //Sorts core data based on distance from current location
            let sortDescriptor = NSSortDescriptor(key: "distance", ascending: true)
            let sortDescriptors = [sortDescriptor]
            fetchRequest.sortDescriptors = sortDescriptors
            //Filters all the artwork in core data to only display the artwork within the building
            fetchRequest.predicate = NSPredicate(format: "location MATCHES[cd] '(\(buildName)).*'")
            
            
            let fetchResults = try PersistenceService.context.fetch(fetchRequest)
            let results = fetchResults as [Artwork] //Core Data
            //Sets title of the cell to the artwork
            cell.textLabel?.text = results[indexPath.row].title!
            //Displays the distance from the user to the artwork
            cell.detailTextLabel?.text = "Distance: \(Int(results[indexPath.row].distance))m"
            
            
        } catch let coreErr {
            print("Error with core data", coreErr)
        }
        
        return cell
    }
    
    //Once an artwork is selected in the table the Artwork view will be displayed for that specific artwork
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ArtworkView") as! ArtworkView
        let currentCell = tableView.cellForRow(at: indexPath) as UITableViewCell!
        newViewController.artTitle = currentCell!.textLabel!.text!
        self.present(newViewController, animated: true, completion: nil)
    }
    

}
