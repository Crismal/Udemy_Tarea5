//
//  QuestionsFactory.swift
//  UdemyQuizApp
//
//  Created by Cristian Misael Almendro Lazarte on 9/12/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import Foundation

class QuestionsFactory{
    
    var questionsBank : QuestionsBank!;
    
    init() {
        //        Esta es la forma manual de cargar datos
        //        if let path = Bundle.main.path(forResource: "QuestionsBank", ofType: "plist"){
        //            if let plist = NSDictionary(contentsOfFile: path){
        //                let questionsData = plist["Questions"] as! [AnyObject]
        //
        //                for question in questionsData{
        //                    if let text = question["question"], let answer = question["answer"], let explanation = question["explanation"]{
        //                        questions.append(Question(text: text as! String, correctAnswer: answer as! Bool, answerExplanation: explanation as! String))
        //                    }
        //                }
        //            }
        //        }
        //        Esta es la forma automatica de cargar datos con el CODABLE
        do {
            if let url = Bundle.main.url(forResource: "QuestionsBank", withExtension: "plist"){
                let data = try Data.init(contentsOf: url);
                
                self.questionsBank = try PropertyListDecoder().decode(QuestionsBank.self, from: data);
                
            }
        }
        catch{
            print(error);
        }
    }
    
    func getQuestionAt(index : Int) -> Question? {
        
        if index < 0 || index >= questionsBank.questions.count{
            return nil;
        }
        else{
            return self.questionsBank.questions[index];
        }
        
    }
    
    func getRandomQuestion() -> Question {
        let index = Int(arc4random_uniform(UInt32( self.questionsBank.questions.count)));
        return self.questionsBank.questions[index];
    }
}

