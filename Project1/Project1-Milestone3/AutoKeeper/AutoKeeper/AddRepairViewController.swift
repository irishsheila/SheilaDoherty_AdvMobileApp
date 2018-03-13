//
//  AddRepairViewController.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/11/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

//Date Format: https://forums.developer.apple.com/thread/50383
//https://medium.com/@tjcarney89/using-dateformatter-to-format-dates-and-times-from-apis-57622ce11d04

import UIKit
import RealmSwift

class AddRepairViewController: UIViewController {

    @IBOutlet weak var vehicle: UITextField!
    @IBOutlet weak var notes: UITextField!
    @IBOutlet weak var repair: UITextField!
    
    var dateConverted = String()
    
    @IBAction func convertDate(_ sender: Any) {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        let repairDate = datePicker.date
        print(repairDate)
        dateConverted = dateformatter.string(from: repairDate)
        print(dateConverted)
    }
    @IBOutlet weak var datePicker: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("prepare for segue activated")
        if segue.identifier == "saveRepairSegue"{
            addNewRepair()
        }
    }
    
    func addNewRepair(){
        let realm = try! Realm()
        try! realm.write {
            let newRepairItem = Repairs() //create a new Repairs instance
            newRepairItem.car = vehicle.text!
            newRepairItem.repair = repair.text!
            newRepairItem.date = dateConverted
            newRepairItem.notes = notes.text!
            realm.add(newRepairItem)
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
