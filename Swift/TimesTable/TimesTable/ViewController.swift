//
//  ViewController.swift
//  TimesTable
//
//  Created by Jonathan Nates on 13/10/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var multip: Int = 1
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "numCell")
        cell.textLabel?.text = "\(indexPath.row + 1) X \(multip) = \((indexPath.row + 1) * (multip))"
        
        return cell
    }
    
    
    @IBOutlet weak var numInput: UITextField!
    @IBOutlet weak var lblWarning: UILabel!
    
    @IBAction func buttonGo(_ sender: Any) {
    
        myTable.isHidden = false
        numInput.resignFirstResponder()
        myTable.reloadData()
        multip = Int(numInput.text!) ?? -1
        numInput.text = ""
        if (multip == -1)
        {
            lblWarning.text = "Select a valid number"
        }
        else
        {
            lblWarning.text = ""
        }
        
        
    }
    
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

