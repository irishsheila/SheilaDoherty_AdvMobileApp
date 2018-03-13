//
//  AddOilChangeViewController.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/12/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import RealmSwift

class AddOilChangeViewController: UIViewController {
    
    var dateConverted = String()

    @IBOutlet weak var mileageTextfield: UITextField!
    @IBAction func dateConvertPicker(_ sender: UIDatePicker) {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .medium
        let repairDate = datePicker.date
        print(repairDate)
        dateConverted = dateformatter.string(from: repairDate)
        print(dateConverted)
    }
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var autoTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveOilSegue"{
            addNewOilChange()
        }
    }
    
    func addNewOilChange(){
        let realm = try! Realm()
        try! realm.write {
            let newOilChange = OilChange() //create a new Repairs instance
            newOilChange.auto = autoTextfield.text!
            newOilChange.mileage = mileageTextfield.text!
            newOilChange.oilDate = dateConverted
            realm.add(newOilChange)
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
