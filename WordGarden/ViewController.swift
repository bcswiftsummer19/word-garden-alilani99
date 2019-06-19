//
//  ViewController.swift
//  WordGarden
//
//  Created by Aidan on 6/9/19.
//  Copyright © 2019 Aidan Lilani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userGuessLabel: UILabel!
    @IBOutlet weak var guessLetterField: UITextField!
    @IBOutlet weak var guessLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    
    
    
    var wordToGuess = "CODE"
    var lettersGuessed = ""
    let maxNumberofWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatUserGuessLabel()
        guessLetterButton.isEnabled = false
        playAgainButton.isHidden = true
        
        
    }
    
    
    func updateUIAfterGuess() {
        guessLetterField.resignFirstResponder()
        guessLetterField.text = ""
    }
    
    func formatUserGuessLabel() {
        var revealedWord = ""
        lettersGuessed += guessLetterField.text!
        
        for letter in wordToGuess {
            if lettersGuessed.contains(letter) {
                revealedWord = revealedWord + " \(letter)"
            } else {
                revealedWord += " _"
            }
            
           
        }
        revealedWord.removeFirst()
        userGuessLabel.text = revealedWord
    }
    
    
    
    
    func guessALetter() {
        formatUserGuessLabel()
        guessCount += 1
        
        let currentLetterGuessed = guessLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed) {
            wrongGuessesRemaining -= 1
            flowerImageView.image = UIImage(named: "flower\(wrongGuessesRemaining)")
        }
        
        let revealedWord = userGuessLabel.text!
        if wrongGuessesRemaining == 0 {
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "You Lost! Try Again?"
        } else if !revealedWord.contains("_") {
            //You've won!
            playAgainButton.isHidden = false
            guessLetterField.isEnabled = false
            guessLetterButton.isEnabled = false
            guessCountLabel.text = "Winner Winner Chicken Dinner! It Took You \(guessCount) Guesses To Guess The Word!"
            guessCount += 1
        } else {
            //update guess #
            let guess = ( guessCount == 1 ? "Guess" : "Guesses")
            //            var guess = "guesses"
            //            if guessCount == 1 {
            //                guess = "guess"
            //            }
            
            guessCountLabel.text = "You've made \(guessCount) \(guess)"
        }
    }
    
    @IBAction func guessLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessLetterField.text?.last {
            guessLetterField.text = "\(letterGuessed)"
            guessLetterButton.isEnabled = true
        } else {
            // disables the button if I don't have a single characted in guessLetterField
            guessLetterButton.isEnabled = false
        }
    }
    
    
    
    @IBAction func doneKeyPressed(_ sender: UITextField){
        guessALetter()
        updateUIAfterGuess()
    }
    
    
    
    @IBAction func guessButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
    }
    
    @IBAction func playAgainButton(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessLetterField.isEnabled = true
        guessLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberofWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've Made Zero Guesses"
        guessCount = 0
    }
    
    
    
    
}

