//
//  NumericViewController.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 09/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

var numAnswer: Int = 0

// Class responsible for dealing with Numeric Questions
class NumericViewController: UIViewController {
    
    var qNum: Int = 0
    

    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationItem!
    @IBOutlet weak var questNum: UILabel!
    @IBOutlet weak var questLabel: UILabel!
    @IBOutlet weak var intLabel: UILabel!
    
    //Stepper responsible for incrementing and decrementing the integer value
    @IBAction func intStepper(_ sender: UIStepper)
    {
        intLabel.text = String(Int(sender.value))
        numAnswer = Int(sender.value)
    }
    
    
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
    
    // Getter method for the answer
    func getNumericAnswer() -> Int
    {
        return numAnswer
    }
    
    // Assigns labels to JSON values
    override func viewDidLoad() {
        super.viewDidLoad()

        questNum.text = questionnaire?.questions[qNum].title
        questLabel.text = questionnaire?.questions[qNum].question
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
