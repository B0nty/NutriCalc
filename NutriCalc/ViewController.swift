//
//  ViewController.swift
//  NutriCalc
//
//  Created by B0nty on 14/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var costumerTableView: UITableView!
    
    var costumers:[Costumer] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        costumerTableView.delegate = self
        costumerTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getCostumer()
        costumerTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { // Function to enable swipe to delete
        return true
    }
    
    // Delete costumer from TableView
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let costumer = costumers[indexPath.row]
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            context.delete(costumer)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            do {
                costumers = try context.fetch(Costumer.fetchRequest())
                tableView.reloadData()
            } catch { }
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costumers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        let costumer = costumers[indexPath.row]
        
        cell.textLabel?.text = "\(costumer.firstName ?? "firstName") \(costumer.lastName ?? "lastName") Age: \(costumer.age ?? "age") \(costumer.sex ?? "sex")"
        return cell
    }
    
    // Perform segue for selected row
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = costumers[indexPath.row]
        
        performSegue(withIdentifier: "showDetailsSegue", sender: selectedCell)
    }
    
    
    // Function to load costumers data from CoreData when program first run or get back to main ViewController
    
    func getCostumer() {
        
        let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            costumers = try context.fetch(Costumer.fetchRequest()) as! [Costumer]
        } catch { }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showDetailsSegue" {
            let nextVC = segue.destination as! showDetailsVC
            nextVC.costumerDetails = sender as? Costumer
        }
        
    }
}

