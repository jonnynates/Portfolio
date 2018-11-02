//
//  MultiOption.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 09/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

var arrAnswers: [Int] = []

class MultiOption: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var qNum: Int = 0
    

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var questLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questNum: UILabel!
    
    /* Submit button that is responsible for deciding what type of view to load for the next question
     * checks the questions type of the next question and then compares it to the different view
     * controls and then decides which view to load.
     * This method also deals with end of questionnaire by seeing if it's the end of JSON file
     */
    @IBAction func btnSubmit(_ sender: Any)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        qNum = qNum + 1
        
        if (qNum >  (questionnaire?.questions.count)!)
        {
            print("end of questionnaire")
            let save = Saving()
            save.saveToCordeData()
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[qNum].type == "single-option")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SingleOption") as! SingleOption
            newViewController.qNum = qNum
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[qNum].type == "multi-option")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MultiOption") as! MultiOption
            newViewController.qNum = qNum
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[qNum].type == "numeric")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "NumericOption") as! NumericViewController
            newViewController.qNum = qNum
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[qNum].type == "text")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "TextOption") as! TextViewController
            newViewController.qNum = qNum
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    /* Back button that is responsible for deciding what type of view to load for the previous question
     * checks the questions type of the previous question and then compares it to the different view
     * controls and then decides which view to load.
     * If current view/question is the first question the main menu view will load instead of a question
     */
    @IBAction func btnBack(_ sender: Any)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        qNum = qNum - 1
        
        if (qNum == -1)
        {
            print("back to main")
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            newViewController.qNum = qNum
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[qNum].type == "single-option")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SingleOption") as! SingleOption
            newViewController.qNum = qNum
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[qNum].type == "multi-option")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MultiOption") as! MultiOption
            newViewController.qNum = qNum
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[qNum].type == "numeric")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "NumericOption") as! NumericViewController
            newViewController.qNum = qNum
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[qNum].type == "text")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "TextOption") as! TextViewController
            newViewController.qNum = qNum
            self.present(newViewController, animated: true, completion: nil)
        }
    }
    
    // sets the number of cells to the number of choices (defaults to 1)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return questionnaire?.questions[qNum].choices.count ?? 1
    }
    
     // populates the table view cells with the questions from the JSON file
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "myCell")
        cell.textLabel?.text = questionnaire?.questions[qNum].choices[indexPath.row].label
        return cell
    }
    
    // When deselecting a cell it then removes the checkmark and removes the answer from the array
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        
        if (cell?.accessoryType == UITableViewCellAccessoryType.checkmark)
        {
            print(arrAnswers.index(of: (indexPath.row + 1))!)
            arrAnswers.remove(at: arrAnswers.index(of: (indexPath.row + 1))!)
            cell!.accessoryType = UITableViewCellAccessoryType.none;
            
        }else
        {
            cell!.accessoryType = UITableViewCellAccessoryType.checkmark;
            
        }
    }
    
    // When selecting a cell it changes the cell to a checkmark and adds the selected cell to an array
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath)
        
        if (cell?.accessoryType == UITableViewCellAccessoryType.checkmark)
        {
            
            cell!.accessoryType = UITableViewCellAccessoryType.none;
            
        }else
        {
            arrAnswers.append(indexPath.row + 1)
            cell!.accessoryType = UITableViewCellAccessoryType.checkmark;
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()
        questNum.text = questionnaire?.questions[qNum].title
        questLabel.text = questionnaire?.questions[qNum].question
        navTitle.title = questionnaire?.title
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   func getMultiAnswer() -> [Int]
   {
    return arrAnswers
    }

}
