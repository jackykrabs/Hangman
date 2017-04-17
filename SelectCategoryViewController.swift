//
//  SelectCategoryViewController.swift
//  Hangman
//
//  Created by Jack Allen on 2/21/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//

import UIKit


class SelectCategoryViewController: UIViewController, SelectCategoryDelegate {

    @IBOutlet var selectCategoryView : SelectCategory!
    var category : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.selectCategoryView.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClick(category: String){
        self.category = category
        performSegue(withIdentifier: "showGame", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let hangmanGameVC = segue.destination as? HangmanGameViewController{
            hangmanGameVC.category = category
        }
    }
    
}
