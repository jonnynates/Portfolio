//
//  PlacesViewController.swift
//  My Favourite Places
//
//  Created by Jonathan Nates on 29/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

var places = [Dictionary<String, String>()]
var currentPlace = -1

class PlacesViewController: UITableViewController {

    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:
        Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        if places[indexPath.row]["name"] != nil {
            cell.textLabel?.text = places[indexPath.row]["name"]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentPlace = indexPath.row
        performSegue(withIdentifier: "to Map", sender: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let fetchRequest: NSFetchRequest<Places> = Places.fetchRequest()
        do
        {
            let fetchResults = try PersistenceService.context.fetch(fetchRequest)
            let results = fetchResults as [Places] //Core Data
            
            if (results.count == 0) {
                    places.remove(at: 0)
                    Saving().saveToCore(name: "Ashton Building", lat: "53.406566", long: "-2.966531")
                    print("saved to core")
                    places.append(["name":"Ashton Building", "lat": "53.406566", "lon": "-2.966531"])
                
            }
            else if (places.count == 1)
            {
                let coreCount = results.count - 1
                places.remove(at: 0)
                for index in 0...coreCount
                {
                    places.append(["name":results[index].name!, "lat": results[index].lat!, "lon": results[index].long!])
                }
               
            }
            
        } catch let coreErr {
            print("core data error", coreErr)
        }
        currentPlace = -1
        table.reloadData()
    }

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let fetchRequest: NSFetchRequest<Places> = Places.fetchRequest()
            do
            {
                let fetchResults = try PersistenceService.context.fetch(fetchRequest)
                let results = fetchResults as [Places] //Core Data
                
                PersistenceService.context.delete(results[indexPath.row])
                
            } catch let coreErr {
                print("core data error", coreErr)
            }
            places.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            table.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
        places.swapAt(fromIndexPath.row, to.row)
    }
    

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
