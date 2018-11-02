//
//  TextViewController.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 09/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

 var textAnswer: String = ""

class TextViewController: UIViewController, UITextViewDelegate {
    
    var qNum: Int = 0
   
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var questNum: UILabel!
    @IBOutlet weak var questLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    /* Submit button that is responsible for deciding what type of view to load for the next question
     * checks the questions type of the next question and then compares it to the different view
     * controls and then decides which view to load.
     * This method also deals with end of questionnaire by seeing if it's the end of JSON file
     */
    @IBAction func btnSubmit(_ sender: Any)
    {
        textAnswer = textView.text
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        qNum = qNum + 1
        if (qNum == (questionnaire?.questions.count)!)
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
    
    // Assigns JSON data to label text
    override func viewDidLoad() {
        super.viewDidLoad()

        questNum.text = questionnaire?.questions[qNum].title
        questLabel.text = questionnaire?.questions[qNum].question
        navTitle.title = questionnaire?.title
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.lightGray
    }
    
    // When done editing assigns text in view to a variable textAnswer
    func textViewDidEndEditing(_ textView: UITextView) {
        textView.backgroundColor = UIColor.white
        textAnswer = textView.text
    }
    
    // This method is responsible for checking that the word limit of 50 isnt reached
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // Checks white space between words and calculates num of words using this
        let spaces = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
        let words = textView.text.components(separatedBy: spaces)
        countLabel.text = "Word count: \(words.count - 1)"
        print(">\(text)<")
        var canChange = true
        
        // If the word count exceeds 50 don't allow the user to edit the text view
        if ((words.count - 1) >= 50) {
            canChange = false
        }
        
        let  char = text.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b") // Compares the current sstring to a back spaece key
        
        //If the next key is a backspace then allow ONLY backspace to work
        //this alows the user to delete words that they had but not add more unless
        // word count is back bellow 50
        if (isBackSpace == -92) {
            print("detected")
            canChange = true
        }
        
        
        
        return canChange
    }
    
    // Getter method for the test answer
    func getTextAnswer() -> String
    {
        return textAnswer
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
