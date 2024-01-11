//
//  ViewController.swift
//  LL
//
//  Created by yucian huang on 2024/1/9.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    var listOfWords = ["apple", "banana", "cookie", "chocolate"]
    let incorrectMovedAllowed = 10
    
    var totalWins = 0 {
        didSet {
            newRond()
        }
    }
    
    var totalLosses = 0 {
        didSet {
            newRond()
        }
    }
    
    var currentGame : Game!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func newRond() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovedAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
            
        } else {
            enableLetterButtons(false)
        }
        func enableLetterButtons(_ enable: Bool) {
            for button in letterButtons {
                button.isEnabled = enable
            }
        }
        
        func updateUI() {
            var letters = [String]()
            for letter in currentGame.formattedWord {
                letters.append(String(letter))
            }
            let wordWithSpacing = letters.joined(separator: " ")
            correctWordLabel.text = wordWithSpacing
            
            scoreLabel.text = " Wins: \(totalWins), Losses: \(totalLosses)"
            treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
        }
        
    }
    @IBAction func letterButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for:  .normal) !
        let letter = Character(letterString.lowercased())
        currentGame.playGuessed(letter: letter)
        updateGameState()
    }

    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
            
        }
    }
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        scoreLabel.text = " Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
}


