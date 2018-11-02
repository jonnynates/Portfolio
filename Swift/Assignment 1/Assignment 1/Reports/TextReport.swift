//
//  TextReport.swift
//  Assignment 1
//
//  Created by Jonathan on 14/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit
import CoreData

class TextReport: UIViewController {

    var currNum: Int = 0
    var results: [Text]? = nil
    
    @IBOutlet weak var lblCount: UILabel!
    
    // Goes to previous report page
    @IBAction func btnBack(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NumericReport") as! NumericReport
        self.present(newViewController, animated: true, completion: nil)
    }
    
    // Goes back to main screen
    @IBAction func btnDone(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    // Goes to next text reply
    @IBAction func btnNext(_ sender: Any)
    {
        if ((currNum == results!.count) || (results!.count == 1) ){
            currNum = 0
            
        }
        else {
            currNum = currNum + 1
        }
        textView.text = "\(results![currNum].text ?? "")"
        lblCount.text = "\(currNum + 1)/\(results!.count)"
    }
    
    // Goes to previous text reply
    @IBAction func btnPrev(_ sender: Any)
    {
        if (results!.count == 1){
            currNum = 0
        }
        else if (currNum == 0) {
            currNum = results!.count
        }
        else {
            currNum = currNum - 1
        }
        textView.text = "\(results![currNum].text ?? "")"
        lblCount.text = "\(currNum + 1)/\(results!.count)"
        
    }
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let textRequest: NSFetchRequest<Text> = Text.fetchRequest()
        
        do{
            let textResults = try PersistenceService.context.fetch(textRequest)
            print(textResults.count)
            
            results = textResults as [Text]
            textView.text = "\(results![currNum].text ?? "")"
            lblCount.text = "\(currNum + 1)/\(results!.count)"
            
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
