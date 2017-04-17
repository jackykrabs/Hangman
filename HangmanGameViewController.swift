//
//  HangmanGameViewController.swift
//  Hangman
//
//  Created by Jack Allen on 2/27/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//

import UIKit


class HangmanGameViewController: UIViewController {

    @IBOutlet var hangmanGameView : HangmanGame!
    var phrase : Phrase?
    var data : String?
    var category: String! // must always have a catagory 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hangmanGameView.myState.getPhrase(category: category)
        hangmanGameView.displayedWord?.text = hangmanGameView.myState.currentPhrase?.word
        hangmanGameView.setDisplayWord()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
