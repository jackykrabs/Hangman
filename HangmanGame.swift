//
//  HangmanGame.swift
//  Hangman
//
//  Created by Jack Allen on 2/23/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//

import UIKit

class HangmanGame: UIView{

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var view : UIView!
    var phrase: Phrase?
    @IBOutlet var gameOverLabel: UILabel?
    @IBOutlet var lettersGuessedDisplay : UILabel?
    @IBOutlet var hangman: UIImageView?
    @IBOutlet var guessLetterTextField : UITextField?
    @IBOutlet var guessWordTextField : UITextField?
    @IBOutlet var displayedWord: UILabel?
    var myState: HangmanState = HangmanState()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupView()
    }
    
    func setupView(){
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "HangmanGame", bundle: bundle)
        view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        lettersGuessedDisplay?.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "cartoonWood"))
        lettersGuessedDisplay?.layer.cornerRadius = 15
        lettersGuessedDisplay?.clipsToBounds = true
        lettersGuessedDisplay?.text = "Letters Guessed: "
        updateHangman()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    @IBAction func guessLetter(){
        //takes the first letter in the text box (should only be one) and checks the letter with the state
        if(!((guessLetterTextField?.text?.isEmpty)!)){
            guessLetterTextField?.text? = (guessLetterTextField?.text?.uppercased())!
            let checkChar : Character = (guessLetterTextField?.text?.remove(at: (guessLetterTextField?.text?.startIndex)!))!
            myState.checkLetter(letter: checkChar)
            guessLetterTextField?.text = ""
            setDisplayWord()
            updateHangman()
        }
    }
    
    @IBAction func guessWord(){
        //takes the whole word from this textbox and checks it with the actual word
        let checkWord : String = (guessWordTextField?.text)!
        myState.checkWord(aWord: checkWord)
        guessWordTextField?.text = ""
        if(myState.complete == true){
            displayedWord?.text? = (myState.currentPhrase?.word)!
        }
        updateHangman()
    }
    
    //set the display word to only display the correct words guessed
    func setDisplayWord(){
        
        displayedWord?.text? = (myState.currentPhrase?.word)! 
        //set the unpicked words in the phrase's word to underscores
        for index in myState.neededLetters{
            if(!(myState.correctLetters.contains(index))){
                let charString : String = "\(index)"
                displayedWord?.text? = (displayedWord?.text?.replacingOccurrences(of: charString, with: " _ "))!
            }
        }
    }
    
    //method to draw the appropriate hangman given the state
    func updateHangman(){
        switch myState.currentState {
        case 0:
            hangman?.image = #imageLiteral(resourceName: "hangman-0")
            break
        case 1:
            hangman?.image = #imageLiteral(resourceName: "hangman-1")
            break
        case 2:
            hangman?.image = #imageLiteral(resourceName: "hangman-2")
            break
        case 3:
            hangman?.image = #imageLiteral(resourceName: "hangman-3")
            break
        case 4:
            hangman?.image = #imageLiteral(resourceName: "hangman-4")
            break
        case 5:
            hangman?.image = #imageLiteral(resourceName: "hangman-5")
            break
        case 6:
            hangman?.image = #imageLiteral(resourceName: "hangman-6")
            break
        case 7:
            hangman?.image = #imageLiteral(resourceName: "hangman-7")
            break
        case 8:
            hangman?.image = #imageLiteral(resourceName: "hangman-8")
            break
        case 9:
            hangman?.image = #imageLiteral(resourceName: "hangman-9")
            break
        default:
            break
        }
        
        var charString : String = ""
        for index in myState.incorrectLetters{
            charString += "\(index) "
        }
        lettersGuessedDisplay?.text = "Letters Guessed: " + charString
        if(myState.complete == true || myState.incorrectLetters.count == 9){
            if(myState.complete == true){
                gameOverLabel?.text = "Congrats! You Win!"
            }else{
                gameOverLabel?.text = "Game Over!"
            }
        }
    }
}
