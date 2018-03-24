//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let allQuestions = QuestionBank()
    var currentIndex : Int = 0
    var score : Int = 0

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        updateQuestionText()
        updateUI()

    }


    @IBAction func answerPressed(_ sender: AnyObject) {

        checkAnswer(selectedAnswer: sender.tag == 1)
        nextQuestion()
        updateUI()
    }
    
    
    func updateUI() {
        let totalQuestions : Int = allQuestions.list.count
        let questionNumber : Int = currentIndex + 1

        scoreLabel.text = "score: \(score)"
        progressLabel.text = "\(questionNumber)/13"
        progressBar.frame.size.width = (view.frame.size.width / CGFloat(totalQuestions)) * CGFloat(questionNumber)
    }
    

    func nextQuestion() {

        if currentIndex + 1 < allQuestions.list.count {
            currentIndex += 1
            updateQuestionText()
        } else {
            let alert = UIAlertController(
                title: "Awesome", message: "You finsh the quizz", preferredStyle: .alert
            )

            let restartAction = UIAlertAction(title: "Restart", style: .default, handler: { (UIAlertAction) in
                self.startOver()
            })

            alert.addAction(restartAction)
            present(alert, animated: true, completion: nil)

        }
        
    }
    
    
    func checkAnswer(selectedAnswer : Bool) {

        if currentQuestion().answer == selectedAnswer {
            score += 1
            ProgressHUD.showSuccess("Correct!")
        } else {
            ProgressHUD.showError("Wrong answer!")
        }
        
    }
    
    
    func startOver() {

        currentIndex = 0
        score = 0
        updateQuestionText()
        updateUI()
       
    }

    func currentQuestion() -> Question {
        return allQuestions.list[currentIndex]
    }

    func updateQuestionText() {
        questionLabel.text = currentQuestion().questionText
    }
    
}
