//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by Mario Jackson on 7/23/22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var timesTapped = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countries.append("estonia")
        countries.append("france")
        countries.append("germany")
        countries.append("ireland")
        countries.append("italy")
        countries.append("monaco")
        countries.append("nigeria")
        countries.append("poland")
        countries.append("russia")
        countries.append("spain")
        countries.append("uk")
        countries.append("us")
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased()) | Score: \(score)"
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        timesTapped += 1
        
        let title = setScore(sender.tag)
        
        let alertController = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        
        
        if timesTapped != 10 {
            present(alertController, animated: true)
        } else {
            self.title = "\(countries[correctAnswer].uppercased()) | Score: \(score)"
            showFinalScore()
        }
    }
    
    private func showFinalScore() {
        let alertController = UIAlertController(title: title, message: "Your final score is \(score).", preferredStyle: .alert)
        
        score = 0
        timesTapped = 0
        
        alertController.addAction(UIAlertAction(title: "Restart", style: .default, handler: askQuestion))
        
        present(alertController, animated: true)
    }
    
    private func setScore(_ chosenTag: Int) -> String {
        var title: String
        
        if chosenTag == correctAnswer {
            title = "Correct"
            score += 1
        } else {
            let tappedCountry = countries[chosenTag].uppercased()
            title = "Wrong. That's the flag of \(tappedCountry)"
            if score > 0  {
                score -= 1
            }
        }
        
        return title
    }
}

