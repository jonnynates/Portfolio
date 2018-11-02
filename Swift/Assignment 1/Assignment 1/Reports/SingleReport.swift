//
//  SingleReport.swift
//  Assignment 1
//
//  Created by Jonathan on 14/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

class SingleReport: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblQuest: UILabel!
    var qNum = 0
    var arrAmounts: [Int] = []
    
    
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MultiReport") as! MultiReport
        self.present(newViewController, animated: true, completion: nil)
    }
    
    // sets the number of cells to the number of choices (defaults to 1)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionnaire?.questions[qNum].choices.count ?? 1
    }
    
    // populates the table view cells with the questions from the JSON file and the answers
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "myCell")
        cell.textLabel?.text = ("\(questionnaire!.questions[qNum].choices[indexPath.row].label): \t\t\t\t\t\t\t \(arrAmounts[indexPath.row])")
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        while (questionnaire?.questions[qNum].type != "single-option") {
            qNum = qNum + 1
        }
        
        let singleRequest: NSFetchRequest<Single> = Single.fetchRequest()
        
        do{
            let singleResults = try PersistenceService.context.fetch(singleRequest)
            let results: [Single] = singleResults
            
            var i = 1
            while (i <= (questionnaire?.questions[qNum].choices.count)!) {
                let amount = results.filter{$0.answer == i}.count
                arrAmounts.append(amount)
                i = i + 1
            }
            
            
        } catch {
            
        }

        lblQuest.text = questionnaire?.questions[qNum].question
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
