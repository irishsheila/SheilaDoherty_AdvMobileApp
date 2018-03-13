//
//  RepairEditViewController.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/12/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import RealmSwift

class RepairEditViewController: UIViewController {
    var date = String()
    @IBOutlet weak var notesTextfield: UITextField!
    var vehicle = String()
    var repair = String()
    @IBOutlet weak var vehicleTextfield: UITextField!
    var notes = String()
    @IBOutlet weak var repairTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vehicleTextfield.text = vehicle
        notesTextfield.text = notes
        repairTextfield.text = repair
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveRepairEditSegue"{
            vehicle = vehicleTextfield.text!
            notes = notesTextfield.text!
            repair = repairTextfield.text!
            
            let repairs = Repairs()
            repairs.car = vehicle
            repairs.date = date
            repairs.notes = notes
            repairs.repair = repair
            
            let realm = try! Realm()
            try! realm.write {
                realm.add(repairs, update: true)
            }
            
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
