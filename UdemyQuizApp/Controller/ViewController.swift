//
//  ViewController.swift
//  UdemyQuizApp
//
//  Created by Cristian Misael Almendro Lazarte on 9/11/18.
//  Copyright © 2018 Cristian Misael Almendro Lazarte. All rights reserved.
//

import UIKit;
import AVFoundation;

class ViewController: UIViewController {
    
    var audioPlayer : AVAudioPlayer!
    
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelQuestionNumber: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    
    @IBOutlet weak var progressBar: UIView!
    
    @IBOutlet weak var questionImage: UIImageView!
    
    var currentScore = 0;
    var currentQuestionId = 0;
    var correctQuestionAnswerd = 0;
    
    let factory = QuestionsFactory();
    
    var currentQuestion : Question!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.startGame();
        
        title = "Quiz App"
        
        //self.updateUIElements()
    }
    
    func startGame() {
        self.currentScore = 0;
        self.currentQuestionId = 0;
        self.correctQuestionAnswerd = 0;
        
        self.factory.questionsBank.questions.shuffle();

        self.factory.questionsBank.questions = Array(self.factory.questionsBank.questions.prefix(10));

        self.askNextQuestion();
    }
    
    func askNextQuestion() {
        
        if let newQuestion = factory.getQuestionAt(index: currentQuestionId){
            self.currentQuestion = newQuestion;
            self.labelQuestion.text = self.currentQuestion.question;
            //self.questionImage.image = UIImage(named: self.currentQuestion.image);
            self.currentQuestionId += 1;
            
            if newQuestion.image != "" {
                let fileName =  newQuestion.image;
                questionImage.image =  UIImage(named: fileName)
            } else {
                questionImage.image = nil;
            }
            
        
        } else {
            //Aquí la new Question es nula -> ya hemos hecho todas las preguntas
            gameOver()
        }
        
    }
    
    func gameOver() {
        //método que se llama cuando no hay más preguntas...
        let alert = UIAlertController(title: "Fin de la partida", message: "Has acertado \(self.correctQuestionAnswerd)/\(self.currentQuestionId). Prueba otra vez!", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (_) in
            self.startGame()
        }
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    func updateUIElements(){
        self.labelScore.text = "Puntuación: \(self.currentScore)"
        self.labelQuestionNumber.text = "\(self.currentQuestionId)/\(self.factory.questionsBank.questions.count)"
        
        for constraint in self.progressBar.constraints {
            if constraint.identifier == "barWidth" {
                constraint.constant = (self.view.frame.size.width)/CGFloat(self.factory.questionsBank.questions.count) * CGFloat(self.currentQuestionId)
            }
        }
    }
    
    @IBAction func buttonPress(_ sender: UIButton) {
        
        var isCorrect = true;
        var sound = "";
        
        if sender.tag == 1 {
            isCorrect = self.currentQuestion.answer == true;
        }
        else
        {
            isCorrect = self.currentQuestion.answer == false;
        }
        
        if(isCorrect){
            self.correctQuestionAnswerd += 1
            self.currentScore += 100*self.correctQuestionAnswerd
            ProgressHUD.showSuccess("Correcto! \n\(self.currentQuestion.explanation)")
            sound = "success";
        }else {
            ProgressHUD.showError("Incorrecto \n\(self.currentQuestion.explanation)")
            sound = "error";
        }
        
        if  let soundURL : URL = Bundle.main.url(forResource: sound, withExtension: "mp3"){
            do{
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL);
            }
            catch{
                print(error);
            }
        }
        
        audioPlayer.play();
        
        self.askNextQuestion();
        self.updateUIElements();
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent;
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
}

