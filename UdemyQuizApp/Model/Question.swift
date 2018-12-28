//
//  Question.swift
//  UdemyQuizApp
//
//  Created by Cristian Misael Almendro Lazarte on 9/11/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import Foundation

class Question :   Codable  {
    
    let image : String;
    let question : String;
    let answer : Bool;
    let explanation : String;
    
//    enum CodingKeys: String, CodingKey {
//        case imageText = "image";
//        case questionText = "question";
//        case answer = "answer";
//        case answerExplanation = "explanation";
//
//    }
    
    init(imageText: String, text: String, correctAnswer: Bool, answerExplanation: String) {
        
        self.image = imageText;
        self.question = text;
        self.answer = correctAnswer;
        self.explanation = answerExplanation;
    }
    
}
 
struct QuestionsBank : Codable {
    var questions : [Question]
}
