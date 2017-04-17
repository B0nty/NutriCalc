//
//  showDetailsVC.swift
//  NutriCalc
//
//  Created by B0nty on 14/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit

class showDetailsVC: UIViewController  {

   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var pal: UILabel!
    @IBOutlet weak var bmr: UILabel!
    @IBOutlet weak var itm: UILabel!
    @IBOutlet weak var cep: UILabel!
    
    
    var costumerDetails : Costumer?
    
    var peviousVc = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = costumerDetails?.firstName
        lastName.text = costumerDetails?.lastName
        age.text = costumerDetails?.age
        gender.text = costumerDetails?.sex
        date.text = costumerDetails?.date
        weight.text = costumerDetails?.weight
        height.text = costumerDetails?.height
        pal.text = costumerDetails?.pal
        bmr.text = costumerDetails?.bmr
        itm.text = costumerDetails?.itm
        cep.text = costumerDetails?.cep
        
        
    }
       
}
