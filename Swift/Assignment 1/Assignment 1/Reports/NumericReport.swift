//
//  NumericReport.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 14/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

class NumericReport: UIViewController {

    @IBOutlet weak var lblQuestion: UILabel!
    @IBOutlet weak var num0: UILabel!
    @IBOutlet weak var num1: UILabel!
    @IBOutlet weak var num2: UILabel!
    @IBOutlet weak var num3: UILabel!
    @IBOutlet weak var num4: UILabel!
    @IBOutlet weak var num5: UILabel!
    
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MultiReport") as! MultiReport
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func btnNext(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "TextReport") as! TextReport
        self.present(newViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var qNum = 0
        while (questionnaire?.questions[qNum].type != "numeric") {
            qNum = qNum + 1
        }
        lblQuestion.text = questionnaire?.questions[qNum].question
        
        
        let numRequest: NSFetchRequest<Numeric> = Numeric.fetchRequest()
        
        do{
            let numResults = try PersistenceService.context.fetch(numRequest)
            print(numResults.count)
            
        
            
            var n0 = 0
            var n1 = 0
            var n2 = 0
            var n3 = 0
            var n4 = 0
            var n5 = 0
            
            // Counts all the values of same type
            let total = numResults.count
            for results in numResults as [Numeric] {
                if (results.value == 0) {
                    n0 = n0 + 1
                }
                else if (results.value == 1) {
                    n1 = n1 + 1
                }
                else if (results.value == 2) {
                    n2 = n2 + 1
                }
                else if (results.value == 3) {
                    n3 = n3 + 1
                }
                else if (results.value == 4) {
                    n4 = n4 + 1
                }
                else if (results.value == 5) {
                    n5 = n5 + 1
                }
            }
            
            num0.text = "0 \t\t\t\t\t\t\t\t\t  \(n0/total * 100)%"
            num1.text = "1 \t\t\t\t\t\t\t\t\t  \(n1/total * 100)%"
            num2.text = "2 \t\t\t\t\t\t\t\t\t  \(n2/total * 100)%"
            num3.text = "3 \t\t\t\t\t\t\t\t\t  \(n3/total * 100)%"
            num4.text = "4 \t\t\t\t\t\t\t\t\t  \(n4/total * 100)%"
            num5.text = "5 \t\t\t\t\t\t\t\t\t  \(n5/total * 100)%"
        } catch {
            print("\(error)")
        }
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
