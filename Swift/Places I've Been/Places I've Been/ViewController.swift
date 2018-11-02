//
//  ViewController.swift
//  Places I've Been
//
//  Created by Jonathan Nates on 20/10/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var myTable: UITableView!
    
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var lblWarn: UILabel!
    
    @IBAction func saveButton(_ sender: Any) {
        let placeText = inputField.text
        
        if (!(placeText == ""))
        {
            //let save = Saving()
            Saving().saveToCore(placeName: placeText!)
        }
        else {
            lblWarn.text = "Please input a place not a blank string"
        }
        inputField.text = ""
        myTable.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let fetchRequest: NSFetchRequest<Places> = Places.fetchRequest()
        var num = 1
        do
        {
            let fetchResults = try PersistenceService.context.fetch(fetchRequest)
            let results = fetchResults as [Places] //Core Data
            num = results.count
        } catch let coreErr {
            print("error with core data", coreErr)
        }
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "placeCell")
        let fetchRequest: NSFetchRequest<Places> = Places.fetchRequest()
        
        do
        {
            let fetchResults = try PersistenceService.context.fetch(fetchRequest)
            let results = fetchResults as [Places] //Core Data
            cell.textLabel?.text = results[indexPath.row].name
        } catch let coreErr {
            print("error with core data", coreErr)
        }
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

