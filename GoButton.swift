//
//  GoButton.swift
//  Hangman
//
//  Created by Jack Allen on 3/7/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//

import UIKit

class GoButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupButton()
    }
    
    func setupButton(){
        self.backgroundColor = UIColor.green
        self.layer.cornerRadius = 25
        self.clipsToBounds = true
        self.tintColor = UIColor.black
    }

}
