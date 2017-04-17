//
//  MainMenu.swift
//  Hangman
//
//  Created by Jack Allen on 1/31/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//

import UIKit
import RealmSwift

protocol MainMenuDelegate : AnyObject{
    func onPlayClick()
    func onInstructionsClick()
}

typealias JSONObject = [String:Any]
typealias JSONArray = [Any]
typealias JSONObjectArray = [JSONObject]


class MainMenu: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    weak var delegate : MainMenuDelegate?
    
    //create variable "title" to load the image into the background
    @IBOutlet var title: UILabel!
    @IBOutlet var pictureView : UIImageView!
    @IBAction func playButtonClick(sender: UIButton){
        delegate!.onPlayClick()
    }
    
    @IBAction func instructionsButtonClick(sender: UIButton){
        delegate!.onInstructionsClick()
    }
    
    //setup stuff for nib
    var view: UIView!
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        setupView();
    }
    
    func setupView(){
        
        //a temporary gamestate to check for updates
        let myState : HangmanState = HangmanState()
        myState.checkForUpdate()

        
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "MainMenu", bundle: bundle)
        view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        title.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "cartoonWood"))
        title.layer.cornerRadius = 15
        title.clipsToBounds = true
        addSubview(view)
    }

}
