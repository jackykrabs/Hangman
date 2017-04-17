//
//  HangmanState.swift
//  Hangman
//
//  Created by Jack Allen on 2/15/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//  This class holds all the logic and state information for Hangman game (Should be held in the hangman game class)
//

import UIKit
import RealmSwift

class HangmanState: NSObject {
    
    //represents the phrase that the user is trying to guess
    var currentPhrase : Phrase? = nil
    
    //represents if you won the game or not
    var win : Bool?
    
    //represents whether you completed the game or not, regardless of whether or not you won
    var complete = false
    
    //realm to hold the phrases
    let phrasesRealm = try! Realm()
    
    //represent the current state of the game
    var currentState : Int
    
    //represent the state of the hangman (retrieved from view to determine which "lines" to call)
    var currentHangman : Int
    
    //collection of characters (letters) that the game fills that contains all the letters of the current phrase word. 
    //the game checks if correctLetters has the same letters as neededLetters, in order to determine if the game is over
    var neededLetters = [Character]()
    
    //collection of characters (letters) that the user has already guessed and have correct
    var correctLetters = [Character]()
    
    //collection of characters (letters) that the user has already guessed and are incorrect
    var incorrectLetters = [Character]()
    
    override init(){
        currentState = 0
        currentHangman = 0
    }
    
    func checkForUpdate(){
        let url = Bundle.main.url(forResource: "data", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let hangmanJSON = json as! [String:Any]
        
        let phrases = hangmanJSON["phrases"] as! [[String:Any]]
        
        let realmPhrasesResults = phrasesRealm.objects(Phrase.self)
        
        //checks if the realm needs to be updated, and if it does, purges the realm and puts all the json stuff in
        if(phrases.count != realmPhrasesResults.count){
            purge()
            putInRealm()
        }
    }
    //method to clear the realm of all objects
    func purge(){
        try! phrasesRealm.write{
            for index in phrasesRealm.objects(Phrase.self){
                phrasesRealm.delete(index)
            }
        }
    }
    
    //method to add a Phrase
    func addPhrase(category: String, word: String){
        try! phrasesRealm.write{
            phrasesRealm.add(Phrase(aCategory: category, aWord: word.uppercased()))
        }
    }
    
    //method to retrieve a random phrase, given a category
    func getPhrase(category: String){
        
        //create the predicate for filtering the results query
        let predicateString = "category = '" + category + "'"
        let predicate = NSPredicate(format: predicateString)
        
        //pull the results into a constant "phrases"
        let phrases = phrasesRealm.objects(Phrase.self).filter(predicate)
        
        //create a random number within the results size to reference a random phrase
        let rand = Int(arc4random_uniform(UInt32(phrases.count)))
        
        //return a the phrases at the index of 'rand', and set the currentPhrase to that phrase
        currentPhrase = phrases[rand]
        
        //since we now have the phrase picked out for the game, fill the neededLetters list
        fillNeededLetters()
    }
    
    //method to check if the letter has already been checked
    func hasBeenChecked(letter: Character) -> Bool {
        if correctLetters.contains(letter) || incorrectLetters.contains(letter){
            return true
        }
        return false
    }
    
    //method to see if the given character is a capital letter (not a digit or special character)
    func isLetter(letter: Character) -> Bool{
        if(letter >= "A" && letter <= "Z"){
            return true
        }
        return false
    }
    
    //method to check if the given word matches the phrase word 
    func checkWord(aWord: String){
        if(aWord.uppercased() == currentPhrase?.word){
            complete = true
        }
        else{
            currentState+=1
        }
    }
    
    //method to check if the given character matches one of the characters in the word
    func checkLetter(letter: Character){
        
        if(isLetter(letter: letter) && !(hasBeenChecked(letter: letter))){
            if(neededLetters.contains(letter)){
                //do stuff to indicate the letter is in the word
                correctLetters.append(letter)
            }
            else{
                incorrectLetters.append(letter)
                currentState+=1
            }
        }else{
            print("Can't check the given character!")
        }
        
        complete = isComplete()
    }
    
    //method to fill neededLetters with the appropriate letters
    func fillNeededLetters(){
        for letter in (currentPhrase?.word.characters.indices)!{
            if((currentPhrase?.word[letter]) != " "){
                if(!(neededLetters.contains((currentPhrase?.word[letter])!))){
                    neededLetters.append((currentPhrase?.word[letter])!)
                }
            }
        }
        
        print("needed letters: ")
        for letter in neededLetters{
            print(letter)
        }
    }
    
    //method to check if the game is complete, by comparing neededLetters and correctLetters (called after each iteration of checkLetter)
    func isComplete() -> Bool{
        for index in neededLetters{
            if(!(correctLetters.contains(index))){
                return false
            }
        }
        return true
    }
    
    //method to add all the phrases from the .json file to the realm (utilizes add phrase)
    func putInRealm(){
        let url = Bundle.main.url(forResource: "data", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let hangmanJSON = json as! [String:Any]
        
        let phrases = hangmanJSON["phrases"] as! [[String:Any]]

        for index in phrases{
            addPhrase(category: index["category"] as! String, word: index["word"] as! String)
        }
    }

}
