//
//  InsertDataVC.swift
//  NutriCalc
//
//  Created by B0nty on 14/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit
import Foundation


class InsertDataVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var itmLbL: UILabel!
    @IBOutlet weak var bmrLbl: UILabel!
    @IBOutlet weak var cepTxt: UITextField!
    @IBOutlet weak var firstNameTxt: UITextField!
    @IBOutlet weak var lastNameTxt: UITextField!
    @IBOutlet weak var ageTxt: UITextField!
    @IBOutlet weak var heightTxt: UITextField!
    @IBOutlet weak var weightTxt: UITextField!
    @IBOutlet weak var sexSwitch: UISegmentedControl!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var palPicker: UIPickerView!
    @IBOutlet weak var palValuesLbl: UILabel!
    @IBOutlet weak var calculationBtn: UIButton!
    
    // Tuple Array values of PAL
    var palValues: [(description: String, value: String)] = [("Choose your lifestyle.....","Select your lifestyle..."),("Extremely inactive", "1.2"),("Exclusively sedentary low activity", "1.4"),("Sedentary activity", "1.5"),("Moderatly low activity", "1.6"),("Moderatly activity", "1.7"),("Medium activity", "1.8"),("Moderately activity", "1.9"),("Vigorously active - low", "2.0"), ("Vigorously active - medium", "2.1"),("Vigorously active - medium", "2.2"),("Vigorously active - high", "2.3"),("Vigorously active - extreme", "2.4")]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return palValues[row].description
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return palValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        palValuesLbl.text = palValues[row].value
        calculationBtn.isEnabled = true
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status and drop into background
        view.endEditing(true)
    }
    
    var sex: String = ""
    let userCalendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        palPicker.dataSource = self
        palPicker.delegate = self
        calculationBtn.isEnabled = false
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(InsertDataVC.dismissKeyboard))
        view.addGestureRecognizer(tap)  // Allows dismiss of keyboard on when tap anywhere on screen besides the keyboard itself
        
        firstNameTxt.autocapitalizationType = .allCharacters  //force UITextField to uppercase input
        lastNameTxt.autocapitalizationType = .allCharacters
        
    }
    
    
    @IBAction func sexSelected() {  // Get value from segment control, converted to String and asign as String to var sex
        
        if (sexSwitch.selectedSegmentIndex == 0) {
            sex = "Male"
        } else if (sexSwitch.selectedSegmentIndex == 1) {
            sex = "Female"
        }
        
    }
    
    
    @IBAction func calcBtnPressed(_ sender: Any) {
        let date = NSDate()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let currentDate = dateFormatter.string(from: date as Date)
        
        let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let costumer = Costumer(context: context)
        
        costumer.firstName = firstNameTxt.text!
        costumer.lastName = lastNameTxt.text!
        costumer.age = ageTxt.text!
        costumer.weight = weightTxt.text!
        costumer.height = heightTxt.text!
        costumer.sex = sex
        costumer.date = currentDate
        costumer.pal = palValuesLbl.text
        
        
        let bmrMan = ((66.47 + (13.75 * (costumer.weight! as NSString).doubleValue) + (5.03 * (costumer.height! as NSString).doubleValue) - (6.75 * (costumer.age! as NSString).doubleValue)) )
        
        let bmrWomen = ((655.10 + (9.56 * (costumer.weight! as NSString).doubleValue) + (1.85 * (costumer.height! as NSString).doubleValue) - (4.68 * (costumer.age! as NSString).doubleValue)) )
        
        let costumerSuare = (costumer.height! as NSString).doubleValue * (costumer.height! as NSString).doubleValue
        
        let itm = ((costumer.weight! as NSString).doubleValue.rounded() / costumerSuare) * 10000
        
        let itmCalc =  String(format: "%.1F", arguments: [itm])
        
        if sex == "Male" {
            bmrLbl.text = String(format: "%.0F", arguments: [bmrMan])
        } else if sex == "Female"{
            bmrLbl.text = String(format: "%.0F", arguments: [bmrWomen])
        }
        
        if sex == "Male" {
            costumer.bmr = String(format: "%.0F", arguments: [bmrMan])
        } else if sex == "Female"{
            costumer.bmr = String(format: "%.0F", arguments: [bmrWomen])
        }
        
        let cepCalc = (palValuesLbl.text! as NSString).doubleValue * (bmrLbl.text! as NSString).doubleValue
        
        cepTxt.text = String(format: "%.0F", arguments: [cepCalc])
        itmLbL.text = itmCalc
        costumer.itm = itmCalc
        dateLbl.text! = currentDate
        costumer.cep = cepTxt.text
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        print(costumer)
    }
    
    
}
