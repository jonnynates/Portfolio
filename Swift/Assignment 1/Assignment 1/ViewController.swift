//
//  ViewController.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 07/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

//Structures for the JSON file
struct Questionnaire: Decodable {
    let id: String
    let title: String
    let description: String
    let questions: [Question]
}

struct Question: Decodable {
    let name: String
    let type: String
    let title: String
    let question: String
    let choices: [Choice]
}

struct Choice: Decodable {
    let label: String
    let value: Int
}

var questionnaire: Questionnaire? = nil


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var urlNum: Int = 0
    var jsonString: String = ""
    var qNum = 0
    
    @IBOutlet weak var picker: UIPickerView!
    
    //Questions text to be displayed in picker view
    let questions = ["Questionnaire 1" , "Questionnaire 2"]
    
   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return questions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return questions[row]
    }
    
    //View picker event that calls setup JSON whenever a different question is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        urlNum = row
        setupJSON()
    }
    


    /* Button responsible for deciding which view controller to load
     * compares the first question type in the JSON to the different view controller types
     * then decides which controller to loud
     * also passes current question numer (qNum 0 is question 1)
     */
    @IBAction func btnQuest(_ sender: Any)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        if (questionnaire?.questions[0].type == "single-option")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SingleOption") as! SingleOption
            newViewController.qNum = 0
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[0].type == "multi-option")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MultiOption") as! SingleOption
            newViewController.qNum = 0
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[0].type == "numeric")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "NumericOption") as! NumericViewController
            newViewController.qNum = 0
            self.present(newViewController, animated: true, completion: nil)
        }
        else if (questionnaire?.questions[0].type == "text")
        {
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "TextOption") as! TextViewController
            newViewController.qNum = 0
            self.present(newViewController, animated: true, completion: nil)
        }

    }
    
    /* Report button that navigates the user to the selected questionnaire report
     * based on the view picker selection
     */
    @IBAction func btnReport(_ sender: Any)
    {
        setupJSON()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SingleReport") as! SingleReport
        self.present(newViewController, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupJSON()
        
    }
    
    /* Class responsible for setting up the JSON file
     * Is called on view load and whenever the a different item is selected on the view picker
     */
    func setupJSON()
    {
        //array that stores all the JSON urls
        // can be expanded to more than 2 URLS because of this method
        let jsonUrlArray = ["https://cgi.csc.liv.ac.uk/~phil/Teaching/COMP327/assignments/questionnaire.json",
                            "https://cgi.csc.liv.ac.uk/~phil/Teaching/COMP327/assignments/questionnaire2.json"]
        jsonString = jsonUrlArray[urlNum]
        guard let url = URL(string: jsonString) else { return }
        
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            guard let data = data else { return }
            
            do {
                let quest = try
                    JSONDecoder().decode(Questionnaire.self, from: data)
                questionnaire = quest
                
                
            } catch  let jsonErr {
                print("Error serialising json", jsonErr)
            }
            }.resume()
    }
    
    
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

