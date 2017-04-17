//
//  GameButton.swift
//  Hangman
//
//  Created by Jack Allen on 3/7/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//

import UIKit

class GameButton: UIButton {

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
    
    //where all the customization of the button happens
    func setupButton(){
        self.setBackgroundImage(#imageLiteral(resourceName: "cartoonWood"), for: UIControlState.normal)
        self.tintColor = UIColor.white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }

}
