//
//  Phrase.swift
//  Hangman
//
//  Created by Jack Allen on 2/15/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//  Class to hold the phrase that is retrieved for the user to guess

import UIKit
import RealmSwift
import Realm

class Phrase: Object {

    //contains the category of the word, used when retrieving the phrase
    dynamic var category: String = ""
    
    //contains the actual value of the word.  Should always be upper case
    dynamic var word: String = ""
    
    //primary id of word
    var primaryID = UUID().uuidString
    
    
    //TODO: Fix the intializer
    convenience init(aCategory: String, aWord: String) {
        self.init()
        category = aCategory
        word = aWord
    }
    
    override static func primaryKey() -> String?{
        return "primaryID"
    }
}
