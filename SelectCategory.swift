//
//  SelectCategory.swift
//  Hangman
//
//  Created by Jack Allen on 2/21/17.
//  Copyright © 2017 Jack Allen. All rights reserved.
//

import UIKit
import RealmSwift

protocol SelectCategoryDelegate: AnyObject{
    func onClick(category: String)
}

class SelectCategory: UIView, UITableViewDelegate, UITableViewDataSource {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    let realm = try! Realm()
    var selectedCategory : String = ""
    weak var delegate: SelectCategoryDelegate!
    @IBOutlet var selectCategoryTitle: UILabel?
    @IBOutlet var tableView: UITableView?
    @IBAction func buttonPressed(){
        if(selectedCategory != ""){
            delegate.onClick(category: selectedCategory)
        }
        else{
            print("you need to pick a category first!")
        }
    }

    
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
        let nib = UINib(nibName: "SelectCategory", bundle: bundle)
        view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "cartoonWood"))
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
        
        selectCategoryTitle?.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "lighterWood"))
        selectCategoryTitle?.layer.cornerRadius = 15
        selectCategoryTitle?.clipsToBounds = true
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.layer.cornerRadius = 15
        tableView?.clipsToBounds = true
    }
    
    //setup stuff for the table view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = getCategories()[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(getCategories().count)
        return getCategories().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell()
        
        cell.textLabel?.text = getCategories()[indexPath.row]
        
        return cell
    }
    
    //pull out only the categories from the realm (checks each element and only adds unique categories to the list
    func getCategories() -> [String]{
        var categories : [String] = []
        let phrases = realm.objects(Phrase.self)
        for index in phrases{
            if (!categories.contains(index.category)){
                categories.append(index.category)
            }
        }
        
        return categories
    }
    
}
