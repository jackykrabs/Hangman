//
//  Directions.swift
//  Hangman
//
//  Created by Jack Allen on 3/8/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//

import UIKit

class Directions: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    @IBOutlet var directionLabel : UILabel?
    //setup stuff for nib
    var view : UIView!
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
        let nib = UINib(nibName: "Directions", bundle: bundle)
        view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "cartoonWood"))
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
    }

}
