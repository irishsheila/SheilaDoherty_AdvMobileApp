//
//  AutoEditViewController.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/10/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import RealmSwift

class AutoEditViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var editYearTextfield: UITextField!
    @IBOutlet weak var editMakeTextfield: UITextField!
    @IBOutlet weak var editModelTextfield: UITextField!
    @IBOutlet weak var editVINTextfield: UITextField!
    @IBOutlet weak var editPhoneTextfield: UITextField!
    @IBOutlet weak var editPolicyTextfield: UITextField!
    @IBOutlet weak var editCompanyTextfield: UITextField!
    var year = String()
    var make = String()
    var model = String()
    var VIN = String()
    var license = String()
    var company = String()
    var policy = String()
    var phone = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        editYearTextfield.text = year
        editMakeTextfield.text = make
        editModelTextfield.text = model
        editVINTextfield.text = VIN
        editCompanyTextfield.text = company
        editPolicyTextfield.text = policy
        editPhoneTextfield.text = phone
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveAutoSegue"{
            year = editYearTextfield.text!
            make = editMakeTextfield.text!
            model = editModelTextfield.text!
            VIN = editVINTextfield.text!
            company = editCompanyTextfield.text!
            policy = editPolicyTextfield.text!
            phone = editPhoneTextfield.text!
            
            //https://academy.realm.io/posts/realm-primary-keys-tutorial/
            let auto = AutoInfo()
            auto.year = year
            auto.make = make
            auto.model = model
            auto.vin = VIN
            auto.license = license
            auto.insuranceco = company
            auto.insurancepolicynum = policy
            auto.insurancephone = phone
            let realm = try! Realm()
            try! realm.write {
                realm.add(auto, update: true)
            }
        }
    }
    
    //keyboard shows
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, moveDistance: -250, up: true)
    }
    
    //keyboard hidden
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textfield: textField, moveDistance: -250, up: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func moveTextField(textfield: UITextField, moveDistance: Int, up: Bool){
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame =  self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
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
