//
//  ViewController.swift
//  Hangman
//
//  Created by Jack Allen on 1/31/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController, MainMenuDelegate {

    @IBOutlet var mainMenuView: MainMenu!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        mainMenuView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onPlayClick(){
        performSegue(withIdentifier: "showSelectScreen", sender: self)
    }

    func onInstructionsClick(){
        performSegue(withIdentifier: "showInstructionsSegue", sender: self)
    }

}

