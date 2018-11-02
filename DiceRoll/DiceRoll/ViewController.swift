//
//  ViewController.swift
//  DiceRoll
//
//  Created by Jonathan Nates on 06/10/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var InputText: UITextField!
    
    
    @IBAction func GuessButton(_ sender: Any) {
        let yourGuess = Int(InputText.text!)
        
        
        let diceRoll = Int((arc4random_uniform(6) + 1) + (arc4random_uniform(6) + 1))
        
        if (diceRoll == yourGuess) {
            DisplayText.text = "You guessed the right number!"
        }
        else {
            DisplayText.text = "You guessed the wrong number! I guessed \(diceRoll)"
        }
        
        InputText.text = ""
        InputText.resignFirstResponder()
            
        
        
    }
    
    
    @IBOutlet weak var DisplayText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

