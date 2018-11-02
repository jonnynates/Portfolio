//
//  Saving.swift
//  Assignment 1
//
//  Created by Jonathan Nates on 13/11/2017.
//  Copyright © 2017 Jonathan Nates. All rights reserved.
//

import Foundation
import CoreData

class Saving {
    
    // Function used for saving all of the question answers to core data
    func saveToCordeData()
    {
        let question: QuestionCore = NSEntityDescription.insertNewObject(forEntityName: "QuestionCore", into: PersistenceService.context) as! QuestionCore
        let multi: Multi = NSEntityDescription.insertNewObject(forEntityName: "Multi", into: PersistenceService.context) as! Multi
        let single: Single = NSEntityDescription.insertNewObject(forEntityName: "Single", into: PersistenceService.context ) as! Single
        let text: Text = NSEntityDescription.insertNewObject(forEntityName: "Text", into: PersistenceService.context) as! Text
        let numeric: Numeric = NSEntityDescription.insertNewObject(forEntityName: "Numeric", into: PersistenceService.context) as! Numeric
        
        question.id = questionnaire?.id
        
        let singleOpt = SingleOption()
        let numOpt = NumericViewController()
        let textOpt = TextViewController()
        let multiOpt = MultiOption()
        
        print("Single Question: \(singleOpt.getQuestion())")
        single.question = singleOpt.getQuestion()
        print("Single: \(singleOpt.getSingleAnswer())")
        single.answer = Int16(singleOpt.getSingleAnswer())
        
        print("Numeric: \(numOpt.getNumericAnswer())")
        numeric.value = Int16(numOpt.getNumericAnswer())
        
        print("Text: \(textOpt.getTextAnswer())")
        text.text = textOpt.getTextAnswer()
        
        let arrNum = multiOpt.getMultiAnswer()
        for num in arrNum
        {
            print("Multi: \(num)")
            multi.answer = Int16(num)
            question.addToMulti(multi)
        }
        
        PersistenceService.saveContext()
        
        
    }
}
