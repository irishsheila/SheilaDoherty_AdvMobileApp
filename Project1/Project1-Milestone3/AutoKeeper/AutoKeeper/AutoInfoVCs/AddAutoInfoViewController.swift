//
//  AddAutoInfoViewController.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/8/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

//TODO: Create alert when all the fields are not added

import UIKit
import RealmSwift

class AddAutoInfoViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var yearTextfiel: UITextField!
    @IBOutlet weak var makeTextfield: UITextField!
    @IBOutlet weak var modelTextfield: UITextField!
    @IBOutlet weak var vinTextfield: UITextField!
    @IBOutlet weak var licenseTextfield: UITextField!
    @IBOutlet weak var companyTextfield: UITextField!
    @IBOutlet weak var policyTextfield: UITextField!
    @IBOutlet weak var phoneTextfield: UITextField!
    
    let newAutoInfoItem = AutoInfo() //create a new AutoInfo instance
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSegue"{
            if((yearTextfiel.text?.isEmpty) == false) &&
               ((makeTextfield.text?.isEmpty) == false) &&
               ((modelTextfield.text?.isEmpty) == false) &&
               ((vinTextfield.text?.isEmpty) == false) &&
               ((licenseTextfield.text?.isEmpty) == false) &&
               ((companyTextfield.text?.isEmpty) == false) &&
               ((policyTextfield.text?.isEmpty) == false) &&
               ((phoneTextfield.text?.isEmpty) == false){
                    newAutoInfoItem.year = yearTextfiel.text!
                    newAutoInfoItem.make = makeTextfield.text!
                    newAutoInfoItem.model = modelTextfield.text!
                    newAutoInfoItem.vin = vinTextfield.text!
                    newAutoInfoItem.license = licenseTextfield.text!
                    newAutoInfoItem.insuranceco = companyTextfield.text!
                    newAutoInfoItem.insurancepolicynum = policyTextfield.text!
                    newAutoInfoItem.insurancephone = phoneTextfield.text!
            }
        }
    }
    
    //tutorial https://www.youtube.com/watch?v=3oFSec6B0y0
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
