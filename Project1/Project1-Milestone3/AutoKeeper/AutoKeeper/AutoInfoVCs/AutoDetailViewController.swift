//
//  AutoDetailViewController.swift
//  AutoKeeper
//
//  Created by Sheila Doherty on 3/10/18.
//  Copyright © 2018 Sheila Doherty. All rights reserved.
//

import UIKit
import RealmSwift

class AutoDetailViewController: UIViewController {
    @IBOutlet weak var detailYear: UILabel!
    @IBOutlet weak var detailMake: UILabel!
    @IBOutlet weak var detailPolicy: UILabel!
    @IBOutlet weak var detailInsurance: UILabel!
    @IBOutlet weak var detailLicense: UILabel!
    @IBOutlet weak var detailVIN: UILabel!
    @IBOutlet weak var detailPhone: UILabel!
    @IBOutlet weak var detailModel: UILabel!
    
    var make = String()
    var model = String()
    var company = String()
    var policy = String()
    var vin = String()
    var phone = String()
    var year = String()
    var license = String()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        detailYear.text = year
        detailMake.text = make
        detailModel.text = model
        detailVIN.text = vin
        detailLicense.text = license
        detailInsurance.text = company
        detailPolicy.text = policy
        detailPhone.text = phone
    } 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editAutoSegue"{
            let nav = segue.destination as! UINavigationController
            let detailVC = nav.topViewController as! AutoEditViewController
            detailVC.year = year
            detailVC.make = make
            detailVC.model = model
            detailVC.company = company
            detailVC.VIN = vin
            detailVC.phone = phone
            detailVC.policy = policy
            detailVC.license = license
        }
    }
    
    @IBAction func unwindfromAutoEditSegue(segue: UIStoryboardSegue){
        if segue.identifier=="saveAutoSegue"{
            let source = segue.source as! AutoEditViewController
            year = source.year
            make = source.make
            model = source.model
            vin = source.VIN
            license = source.license
            company = source.company
            policy = source.policy
            phone = source.phone
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
