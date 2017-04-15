//
//  InsertDataVC.swift
//  NutriCalc
//
//  Created by B0nty on 14/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit

class InsertDataVC: UIViewController {
    
    @IBOutlet weak var itmLbL: UILabel!
    @IBOutlet weak var bmrLbl: UILabel!
    @IBOutlet weak var cepLbl: UILabel!
    @IBOutlet weak var itmTableView: UITableView!
    @IBOutlet weak var palTableView: UITableView!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var ageTxt: UITextField!
    @IBOutlet weak var heightTxt: UITextField!
    @IBOutlet weak var weightTxt: UITextField!
    @IBOutlet weak var sexSwitch: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstNameTxt.autocapitalizationType = .allCharacters  //force UITextField to uppercase input
        lastNameTxt.autocapitalizationType = .allCharacters
    }
    
    
    @IBAction func calcBtnPressed(_ sender: Any) {
        
        let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let costumer = Costumer(context: context)
        
        costumer.firstName = firstNameTxt.text!
        costumer.lastName = lastNameTxt.text!
        costumer.age = ageTxt.text!
        costumer.weight = weightTxt.text!
        costumer.height = heightTxt.text!
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
    }
    
}
