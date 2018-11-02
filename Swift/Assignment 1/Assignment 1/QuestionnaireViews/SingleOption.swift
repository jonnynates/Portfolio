//
//  SingleOption.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 09/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

var sAnswer: Int = 0
var qString: String = ""

class SingleOption: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var qNum: Int = 0
    
    /* Submit button that is responsible for deciding what type of view to load for the next question
     * checks the questions type of the next question and then compares it to the different view
     * controls and then decides which view to load.
     * This method also deals with end of questionnaire by seeing if it's the end of JSON file
     */
    @IBAction func btnSubmit(_ sender: Any) {
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
    
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var questLabel: UILabel!
    @IBOutlet weak var questNum: UILabel!
    
    // sets the number of cells to the number of choices (defaults to 1)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionnaire?.questions[qNum].choices.count ?? 1
    }
    
    // populates the table view cells with the questions from the JSON file
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default , reuseIdentifier: "myCell")
        cell.textLabel?.text = questionnaire?.questions[qNum].choices[indexPath.row].label
        return cell
    }
    
    // assigns the answer to the selected choice by the user (defaults to 0)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        sAnswer = questionnaire?.questions[qNum].choices[indexPath.row].value ?? 0
    }
    
    // Getter method for the answer
    func getSingleAnswer() -> Int
    {
        return sAnswer
    }
    
    // Getter method for the question
    func getQuestion() -> String
    {
        return qString
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.tableFooterView = UIView()
        questNum.text = questionnaire?.questions[qNum].title
        qString = String((questionnaire?.questions[qNum].question)!)
        print(qString)
        questLabel.text = qString
        navTitle.title = questionnaire?.title
        
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
