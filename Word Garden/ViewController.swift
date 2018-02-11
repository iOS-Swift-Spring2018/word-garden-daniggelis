//
//  ViewController.swift
//  Word Garden
//
//  Created by Tiffany on 2/4/18.
//  Copyright © 2018 Tiffany. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var UserGuessLabel: UILabel!
    @IBOutlet weak var guessedLetterField: UITextField!
    @IBOutlet weak var guessedLetterButton: UIButton!
    @IBOutlet weak var guessCountLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var flowerImageView: UIImageView!
    var wordToGuess = "CODE"
    var lettersGuessed = ""
    let maxNumberOfWrongGuesses = 8
    var wrongGuessesRemaining = 8
    var guessCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guessedLetterButton.isEnabled = false
        playAgainButton.isEnabled = true
        formatUserGuessLabel()
       
    }
    
    func updateUIAfterGuess(){
        guessedLetterField.resignFirstResponder()
        guessedLetterField.text = ""
    }
    
    @IBAction func guessedLetterFieldChanged(_ sender: UITextField) {
        if let letterGuessed = guessedLetterField.text?.last{
            guessedLetterField.text = "\(letterGuessed)"
            guessedLetterButton.isEnabled = true
        }else{
            guessedLetterButton.isEnabled = false
        }
        
    }
    
    func formatUserGuessLabel(){
        var revealedWord = ""
        lettersGuessed += guessedLetterField.text!
        for letter in wordToGuess{
            if lettersGuessed.contains(letter){
                revealedWord = revealedWord + " " + String(letter)
            }else{
                revealedWord += " _"
            }
        }
        revealedWord.removeFirst()
        UserGuessLabel.text = revealedWord
    }
    
    func guessALetter(){
        formatUserGuessLabel()
        guessCount += 1
        
        //decrements the wrongGuessesRemaining and shows next flower image with one less petal
        let currentLetterGuessed = guessedLetterField.text!
        if !wordToGuess.contains(currentLetterGuessed){
            wrongGuessesRemaining -= 1
            flowerImageView.image = UIImage(named: "flower" + String(wrongGuessesRemaining))
        }
        
        let revealedWord = UserGuessLabel.text!
        //stop game if wrongGuessesRemaining = 0
        if wrongGuessesRemaining == 0{
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessedLetterButton.isEnabled = false
            guessCountLabel.text = "So sorry, you're all out of guesses. Try again?"
        } else if !revealedWord.contains("_"){
            //You've won a game!
            playAgainButton.isHidden = false
            guessedLetterField.isEnabled = false
            guessedLetterButton.isEnabled = false
            guessCountLabel.text = "You've won! It took you \(guessCount) guesses to guess the word!"
        }else{
            //update our guess count
//            var guess = "guess"
//            if guessCount == 1{
//                guess = "guess"
            
            let guess = (guessCount == 1 ? "guess" : "guesses")
             guessCountLabel.text = "You've made \(guessCount) \(guess)!"
        }
        }

    
    @IBAction func doneKeyPressed(_ sender: UITextField) {
        guessALetter()
        updateUIAfterGuess()
        
    }
    
    @IBAction func guessLetterButtonPressed(_ sender: UIButton) {
        guessALetter()
        updateUIAfterGuess()
        
    }
    
    @IBAction func playAgainButtonPressed(_ sender: UIButton) {
        playAgainButton.isHidden = true
        guessedLetterField.isEnabled = true
        guessedLetterButton.isEnabled = false
        flowerImageView.image = UIImage(named: "flower8")
        wrongGuessesRemaining = maxNumberOfWrongGuesses
        lettersGuessed = ""
        formatUserGuessLabel()
        guessCountLabel.text = "You've made 0 guesses."
        guessCount = 0
    }
    


}

